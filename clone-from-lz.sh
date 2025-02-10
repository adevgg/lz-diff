#!/bin/bash

# 检查是否提供了 image_name
if [ -z "$1" ]; then
  echo "请提供一个 Docker 镜像名称作为参数。"
  exit 1
fi

IMAGE_NAME=$1

# 拉取 Docker 镜像
echo "正在拉取 Docker 镜像: $IMAGE_NAME"
docker pull $IMAGE_NAME

# 创建一个临时容器
CONTAINER_ID=$(docker create $IMAGE_NAME)

rm -rf ./lz
# 创建 /lz 目录
mkdir -p ./lz

# 从容器中复制 /app 目录到 /lz
echo "正在从容器中提取 /app 目录..."
docker cp $CONTAINER_ID:/app ./lz

# 删除临时容器
docker rm $CONTAINER_ID

# 进入 /lz 目录
cd ./lz/app

# 初始化 git 仓库
echo "正在初始化 git 仓库..."
git init

# 设置项目级别的用户信息
git config user.name "Your Name"
git config user.email "your.email@example.com"

# 添加所有文件并提交
git add .
git commit -m "Initial commit"

# 创建 archive.zip
echo "正在创建 archive.zip..."
git archive -o ../../archive.zip HEAD

# 返回到原始目录
cd ../..

echo "操作完成，archive.zip 已创建。"

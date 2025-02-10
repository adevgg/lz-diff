#!/bin/bash

# 检查是否提供了 GitHub 仓库 URL 和分支/标签名
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "请提供 GitHub 仓库 URL 和分支/标签名作为参数。"
  echo "用法: $0 <github_repo> <branch_or_tag>"
  exit 1
fi

GITHUB_REPO=$1
BRANCH_OR_TAG=$2

# 克隆 GitHub 仓库
echo "正在克隆 GitHub 仓库: $GITHUB_REPO"
git clone $GITHUB_REPO repo

# 进入克隆的仓库目录
cd repo

# 切换到指定的分支或标签
echo "正在切换到分支/标签: $BRANCH_OR_TAG"
git checkout $BRANCH_OR_TAG

# 移除 .git 目录
echo "正在移除 .git 目录..."
rm -rf .git
rm -rf README.md

# 重新初始化 git 仓库
echo "正在重新初始化 git 仓库..."
git init

# 设置项目级别的用户信息
git config user.name "Your Name"
git config user.email "your.email@example.com"

cp ../lz-gitignore ./.gitignore

# 添加所有文件并提交
git add .
git commit -m "Initial commit"

# 创建 archive.zip
echo "正在创建 archive.zip..."
git archive -o ../archive.zip HEAD

# 返回到原始目录
cd ..

# 可选：删除克隆的仓库目录
rm -rf repo

echo "操作完成，archive.zip 已创建。"


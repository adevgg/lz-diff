#!/bin/bash

rm -rf lz-pruned

# 解压缩 archive.zip 到 lz-pruned 目录
echo "正在解压缩 archive.zip 到 lz-pruned 目录..."
unzip -q archive.zip -d lz-pruned

# 进入 lz-pruned 目录
cd lz-pruned

# 设置 LC_COLLATE 以确保一致的排序顺序
export LC_COLLATE=C

# 获取所有文件，基于项目相对路径排序，计算每个文件的内容的哈希值
echo "计算每个文件的哈希值..."
HASHES=""
while IFS= read -r file; do
  # 计算文件的哈希值
  FILE_HASH=$(sha256sum "$file" | awk '{print $1}')
  # 组合相对路径和哈希值
  HASHES+="$file $FILE_HASH\n"
done < <(find . -type f | sort)

# 将 HASHES 写入一个文件
echo -e "$HASHES" > ../file_hashes.txt
echo "文件哈希值已写入 file_hashes.txt"

# 计算项目的哈希值
echo "计算项目的哈希值..."
PROJECT_HASH=$(echo -e "$HASHES" | sha256sum | awk '{print $1}')

# 输出结果
echo "项目的哈希值: $PROJECT_HASH"

# 返回到原始目录
cd ..

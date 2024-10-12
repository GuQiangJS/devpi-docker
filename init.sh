#!/bin/bash
set -e

# 检查 /data 目录是否存在
if [ ! -d /data ]; then
  echo "Creating /data directory..."
  mkdir -p /data
fi

# 检查 .initialized 标志文件是否存在
if [ ! -f /data/.initialized ]; then
  echo "Initializing devpi-server..."
  devpi-init

  # 创建一个标志文件，表示已经初始化
  touch /data/.initialized
else
  echo "Devpi-server already initialized, skipping initialization."
fi

# 启动 devpi-server
echo "Starting devpi-server..."
exec devpi-server --host=0.0.0.0 --port=3141 &
sleep 5  # 等待 devpi-server 启动

# 检查是否有 .configured 标志文件，如果没有则进行配置
if [ ! -f /data/.configured ]; then
  echo "Configuring devpi-server..."

  # 登录到 devpi-server
  /usr/local/bin/devpi use http://0.0.0.0:3141
  /usr/local/bin/devpi login root --password=123456

  # 修改 pypi 索引的镜像源
  /usr/local/bin/devpi index root/pypi "mirror_web_url_fmt=https://mirrors.aliyun.com/pypi/simple/{name}/" "mirror_url=https://mirrors.aliyun.com/pypi/simple/"

  # 创建一个标志文件，表示已经配置过
  touch /data/.configured
else
  echo "Devpi-server already configured, skipping configuration."
fi

# 保持容器运行
wait

FROM python:3.11-slim

# 设置工作目录
WORKDIR /usr/src/app

# 安装 devpi-server
RUN pip install -i https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple --no-cache-dir devpi-server[postgres] devpi-client

# 暴露端口
EXPOSE 3141

# 添加 init.sh 脚本
COPY init.sh /init.sh
RUN chmod +x /init.sh

# 使用 init.sh 作为入口点
CMD ["/init.sh"]

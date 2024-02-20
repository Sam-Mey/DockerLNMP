FROM gcc:latest

WORKDIR /data

COPY ./jemalloc.cpp /data/

# 编译jemalloc
RUN g++ -o jemalloc jemalloc.cpp

# 添加设置内存过commit的命令
RUN echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf

# 运行 sysctl 命令
RUN sysctl vm.overcommit_memory=1

CMD ["./jemalloc"]

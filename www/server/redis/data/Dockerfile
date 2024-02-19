FROM gcc:latest

WORKDIR /data

COPY ./DockerLNMP/www/redis/data/jemalloc.cpp /data/

RUN g++ -o jemalloc jemalloc.cpp

CMD ["./jemalloc"]

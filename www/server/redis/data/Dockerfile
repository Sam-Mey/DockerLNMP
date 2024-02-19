FROM gcc:latest

WORKDIR /data

COPY /DockerLNMP/www/server/redis/data/jemalloc.cpp /data/

RUN g++ -o jemalloc jemalloc.cpp

CMD ["./jemalloc"]

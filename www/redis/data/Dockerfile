FROM gcc:latest

WORKDIR /data

COPY redis/jemalloc.cpp /data/

RUN g++ -o jemalloc jemalloc.cpp

CMD ["./jemalloc"]

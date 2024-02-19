FROM gcc:latest

WORKDIR /data

COPY ./data/jemalloc.cpp /data/

RUN g++ -o jemalloc jemalloc.cpp

CMD ["./jemalloc"]

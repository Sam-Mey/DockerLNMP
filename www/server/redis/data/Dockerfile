FROM gcc:latest

WORKDIR /data

COPY ./jemalloc.cpp /data/

RUN g++ -o jemalloc jemalloc.cpp

CMD ["./jemalloc"]

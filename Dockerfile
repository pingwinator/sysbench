FROM ubuntu:latest
MAINTAINER Vasyl Liutikov <pingwinator@gmail.com>
# install binary and remove cache
RUN apt-get update && apt-get install -y sysbench && rm -rf /var/lib/apt/lists/*

#run cpu test with 20k prime
ENTRYPOINT /usr/bin/sysbench cpu --cpu-max-prime=20000 run

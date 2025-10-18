FROM debian:sid
LABEL maintainer="Vasyl Liutikov <pingwinator@gmail.com>"

# Install sysbench from repository
RUN apt-get update && apt-get install -y --no-install-recommends \
    sysbench \
    && rm -rf /var/lib/apt/lists/*

# Run cpu test with 20k prime
ENTRYPOINT ["/usr/bin/sysbench", "cpu", "--cpu-max-prime=20000", "run"]

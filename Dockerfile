FROM debian:sid
LABEL maintainer="Vasyl Liutikov <pingwinator@gmail.com>" \
      org.opencontainers.image.title="Sysbench" \
      org.opencontainers.image.description="Multi-architecture Docker image for sysbench CPU, memory, and I/O benchmarks" \
      org.opencontainers.image.licenses="GPL-2.0" \
      org.opencontainers.image.source="https://github.com/pingwinator/sysbench" \
      org.opencontainers.image.documentation="https://github.com/pingwinator/sysbench/blob/main/README.md"

# Install sysbench from repository
RUN apt-get update && apt-get install -y --no-install-recommends \
    sysbench \
    && rm -rf /var/lib/apt/lists/*

# Run cpu test with 20k prime
ENTRYPOINT ["/usr/bin/sysbench", "cpu", "--cpu-max-prime=20000", "run"]

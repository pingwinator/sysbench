# Sysbench Docker Image

Multi-architecture Docker image for running [sysbench](https://github.com/akopytov/sysbench) benchmarks. Perfect for testing CPU, memory, and I/O performance across different platforms.

[![Docker Image CI](https://github.com/pingwinator/sysbench/actions/workflows/ci.yml/badge.svg)](https://github.com/pingwinator/sysbench/actions/workflows/ci.yml)

## Supported Architectures

- `linux/amd64` (x86_64)
- `linux/arm64` (aarch64)
- `linux/riscv64`

## Quick Start

Run a CPU benchmark with default settings (20,000 prime numbers):

```bash
docker run --rm pingwinator/sysbench:latest
```

## Usage Examples

### CPU Benchmark

**Default test (20k prime):**
```bash
docker run --rm pingwinator/sysbench:latest
```

**Custom prime limit:**
```bash
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  cpu --cpu-max-prime=50000 run
```

**Multi-threaded test:**
```bash
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  cpu --threads=4 --cpu-max-prime=20000 run
```

**Longer test duration:**
```bash
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  cpu --time=60 --cpu-max-prime=20000 run
```

### Memory Benchmark

```bash
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  memory --memory-total-size=10G run
```

**Sequential memory access:**
```bash
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  memory --memory-access-mode=seq --memory-total-size=10G run
```

### File I/O Benchmark

**Prepare test files:**
```bash
docker run --rm -v $(pwd)/testfiles:/testfiles \
  --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  fileio --file-total-size=2G --file-test-mode=rndrw prepare
```

**Run random read/write test:**
```bash
docker run --rm -v $(pwd)/testfiles:/testfiles \
  --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  fileio --file-total-size=2G --file-test-mode=rndrw run
```

**Cleanup:**
```bash
docker run --rm -v $(pwd)/testfiles:/testfiles \
  --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  fileio --file-total-size=2G cleanup
```

### Threads Benchmark

```bash
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  threads --threads=64 run
```

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Performance Test
on: [push]
jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - name: Run CPU Benchmark
        run: docker run --rm pingwinator/sysbench:latest
```

### GitLab CI Example

```yaml
benchmark:
  stage: test
  image: docker:latest
  services:
    - docker:dind
  script:
    - docker run --rm pingwinator/sysbench:latest
```

## Output Format

The default CPU test outputs performance metrics including:

- **Events per second** - Primary performance metric
- **Total time** - Test duration
- **Total events** - Number of operations completed
- **Latency statistics** - Min, avg, max, and 95th percentile
- **Thread fairness** - Distribution across threads

Example output:
```
sysbench 1.0.20 (using system LuaJIT 2.1.1723681758)

Running the test with following options:
Number of threads: 1

CPU speed:
    events per second:  1651.90

General statistics:
    total time:                          10.0003s
    total number of events:              16521

Latency (ms):
         min:                                    0.60
         avg:                                    0.61
         max:                                    2.51
         95th percentile:                        0.61
```

## Available Images

- Docker Hub: `docker pull pingwinator/sysbench:latest`
- GitHub Container Registry: `docker pull ghcr.io/pingwinator/sysbench:latest`

## Building Locally

```bash
# Single architecture
docker build -t sysbench .

# Multi-architecture (requires buildx)
docker buildx build --platform linux/amd64,linux/arm64,linux/riscv64 \
  -t pingwinator/sysbench:latest .
```

## License

This Docker image packages sysbench, which is licensed under GPL-2.0.

## Links

- [Sysbench GitHub Repository](https://github.com/akopytov/sysbench)
- [Sysbench Documentation](https://github.com/akopytov/sysbench#documentation)

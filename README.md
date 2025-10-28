# Sysbench Docker Image

Multi-architecture Docker image for running [sysbench](https://github.com/akopytov/sysbench) benchmarks. Perfect for testing CPU, memory, and I/O performance across different platforms.

[![Docker Image CI](https://github.com/pingwinator/sysbench/actions/workflows/ci.yml/badge.svg)](https://github.com/pingwinator/sysbench/actions/workflows/ci.yml)

## Supported Architectures

- `linux/amd64` (x86_64) - Intel/AMD 64-bit
- `linux/386` (i386) - Intel/AMD 32-bit
- `linux/arm64` (aarch64) - ARM 64-bit
- `linux/arm/v7` (armv7) - ARM 32-bit v7
- `linux/arm/v6` (armv6) - ARM 32-bit v6
- `linux/riscv64` - RISC-V 64-bit

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
docker buildx build --platform linux/amd64,linux/arm64,linux/riscv64,linux/arm/v7,linux/arm/v6,linux/386 \
  -t pingwinator/sysbench:latest .
```

## Benchmark Results

This image has been extensively tested on **21 different systems** across **6 architectures**:

### Tested Platforms

- **13 x86_64 systems**: Intel i5-13600, i5-8250U, i5-6500, i5-4590T, Pentium N6005, i3-8100T, Celeron 1007U/J4025/J4105/J3355/J1800, AMD Ryzen R1505G, AMD G-T56N (Fustro S900 - D3003)
- **6 ARM64 systems**: Apple M1 Mac mini, Apple M1 Pro MacBook Pro 14", Rockchip RK3588S, Raspberry Pi 5/4/3
- **1 ARMv6 system**: Raspberry Pi Zero W
- **1 RISC-V system**: StarFive VisionFive 2

### Key Findings

- **NEW CHAMPION**: Apple M1 (4,046 evt/s) - 2.46x faster than Intel i5-13600 in single-thread!
- **Performance range**: 1,400x difference between fastest (Apple M1: 4,046 evt/s) and slowest (RPi Zero W: 2.89 evt/s)
- **Best efficiency**: Intel Pentium N6005, SiFive U74 - 99% multi-thread scaling
- **ARM dominance**: Apple M1 proves ARM can outperform x86 in both efficiency and raw performance
- **32-bit penalty**: Up to 94% performance loss on ARM64, but 0% on AMD Ryzen R1505G
- **NAS performance**: Synology DS220+ (642 evt/s) significantly outperforms QNAP TS-251+ (153 evt/s)
- **Rosetta 2 efficiency**: Only 27% performance loss for x86_64 emulation on Apple M1

📊 **Full benchmark results**: See [BENCHMARK_RESULTS.md](BENCHMARK_RESULTS.md) for detailed performance analysis, comparison charts, and platform-specific insights.

### Container Runtime Support

Tested with **Docker**, **Podman**, and **Apple Container** on various platforms:
- ✅ Docker: Desktop systems, NAS devices (Synology, QNAP), thin clients, macOS
- ✅ Podman: Raspberry Pi systems, Orange Pi 5
- ✅ Apple Container: macOS 15+ with native ARM64 and Rosetta 2 support

## License

This Docker image packages sysbench, which is licensed under GPL-2.0.

## Links

- [Sysbench GitHub Repository](https://github.com/akopytov/sysbench)
- [Sysbench Documentation](https://github.com/akopytov/sysbench#documentation)
- [Full Benchmark Results](BENCHMARK_RESULTS.md)

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

This image has been extensively tested on **20+ different systems** across **6 architectures**.

### Key Findings

- **Single-Thread Champion**: Apple M1 is the king of single-threaded performance with **4,046 events/sec**, outperforming the Intel i5-13600 by 2.46x.
- **Multi-Thread Champion**: The Intel i5-13600 dominates multi-threaded workloads with **18,113 events/sec**, leveraging its 20-core hybrid architecture.
- **Best Scaling Efficiency**: Simpler, homogeneous architectures (like the Intel Pentium N6005, Core i3-8100T, and SiFive U74) achieve near-perfect **99% scaling efficiency**.
- **ARM vs x86**: Modern ARM SoCs like the Apple M1, Rockchip RK3588S, and Raspberry Pi 5 are highly competitive and often outperform budget x86 CPUs.
- **32-bit Performance**: A significant performance penalty exists in 32-bit mode on modern CPUs. The AMD Ryzen R1505G is a standout, showing **0% performance loss**.
- **Virtualization & Emulation**: Apple's Rosetta 2 is remarkably efficient (-27% loss), while WSL2 shows catastrophic memory performance degradation (-88%).

📊 **Full benchmark results**: See [BENCHMARK_RESULTS.md](BENCHMARK_RESULTS.md) for top performers, or visit the [📊 Wiki](https://github.com/pingwinator/sysbench/wiki) for detailed performance analysis, comparison charts, and platform-specific insights.

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
- [Benchmark Results Summary](BENCHMARK_RESULTS.md)
- [Complete Benchmark Results (Wiki)](https://github.com/pingwinator/sysbench/wiki)

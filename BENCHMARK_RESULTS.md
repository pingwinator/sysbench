# Sysbench Benchmark Results

This Docker image has been extensively tested on **20+ different systems** across **6 architectures** to validate multi-architecture support and measure real-world performance.

📊 **[View Complete Benchmark Results in Wiki →](https://github.com/pingwinator/sysbench/wiki)**

## Quick Summary

All benchmarks were conducted using Docker containers on real hardware (not emulated) to ensure consistency across platforms.

**Test Date:** October 2025
**Docker Image:** `pingwinator/sysbench:latest`
**Systems Tested:** 20+ (x86_64, ARM64, ARMv6, RISC-V)

## 🏆 Top 10 Performers (Single-Thread CPU)

| Rank | System | Processor | Architecture | Events/sec | Notes |
|------|--------|-----------|--------------|------------|-------|
| 1 | Mac mini (2020) | Apple M1 | ARM64 | **4,046** | 🏆 Champion - 2.46x faster than i5-13600 |
| 2 | MacBook Pro 14" | Apple M1 Pro | ARM64 | **3,973** | 2.42x faster than i5-13600 |
| 3 | Desktop PC | Intel Core i5-13600 | x86_64 | **1,642** | Fastest x86 CPU |
| 4 | Raspberry Pi 5 | Cortex-A76 (BCM2712) | ARM64 | **1,013** | Best Raspberry Pi |
| 5 | Orange Pi 5 | Rockchip RK3588S | ARM64 | **980** | ARM SoC powerhouse |
| 6 | Dell Wyse 3000 | Pentium Silver N6005 | x86_64 | **775** | Best budget x86 |
| 7 | Synology DS220+ | Celeron J4025 | x86_64 | **642** | Best NAS performance |
| 8 | Raspberry Pi 4 | Cortex-A72 (BCM2711) | ARM64 | **575** | Solid ARM SBC |
| 9 | Synology DS218+ | Celeron J3355 | x86_64 | **467** | Older NAS |
| 10 | ThinkPad T480 | Core i5-8250U | x86_64 | **436** | Laptop performance |

## Key Findings

- **ARM Dominance**: Apple M1 proves ARM can outperform x86 in both efficiency and raw performance
- **Performance Range**: 1,400x difference between fastest (M1: 4,046 evt/s) and slowest (RPi Zero W: 2.89 evt/s)
- **Best Efficiency**: Intel Pentium N6005, i3-8100T, i5-4590T, SiFive U74 - all achieve **99% multi-thread scaling**
- **32-bit Penalty**: Up to 94% performance loss on ARM64, but **0% loss on AMD Ryzen R1505G**
- **NAS Performance**: Synology DS220+ (642 evt/s) significantly outperforms older QNAP TS-251+ (153 evt/s)
- **Memory Champion**: i5-13600 with DDR5 achieves 101.7 GB/s read speed
- **Rosetta 2 Efficiency**: Only 27% performance loss for x86_64 emulation on Apple M1

## 🏅 Champions by Category

| Category | Winner | Performance |
|----------|--------|-------------|
| **Single-Thread CPU** | Apple M1 | 4,046 events/sec |
| **Multi-Thread CPU** | Intel i5-13600 | 18,113 events/sec (20 cores) |
| **Scaling Efficiency** | Intel Pentium N6005, i3-8100T, i5-4590T, SiFive U74 | 99% |
| **Memory Read** | Intel i5-13600 (DDR5) | 101.7 GB/s |
| **Memory Write** | Intel i5-13600 (DDR5) | 18.2 GB/s |
| **32-bit Performance** | AMD Ryzen R1505G | 0% performance loss |
| **Budget Champion** | Intel Pentium N6005 | 775 evt/s, 99% efficiency |
| **ARM SBC** | Raspberry Pi 5 | 1,013 evt/s |
| **NAS** | Synology DS220+ | 642 evt/s |

## Tested Platforms

### x86_64 (13 systems)
Intel i5-13600, i5-8250U, i5-6500, i5-4590T, Pentium N6005, i3-8100T, Celeron 1007U/J4025/J4105/J3355/J1800, AMD Ryzen R1505G, AMD G-T56N

### ARM64 (6 systems)
Apple M1 (Mac mini), Apple M1 Pro (MacBook Pro 14"), Rockchip RK3588S (Orange Pi 5), Raspberry Pi 5/4/3

### ARMv6 (1 system)
Raspberry Pi Zero W

### RISC-V (1 system)
SiFive U74-MC (StarFive VisionFive 2)

## 📚 Full Documentation

For complete benchmark results, detailed system analysis, memory performance, I/O tests, 32-bit comparisons, and reproducibility instructions, visit:

**[📊 Complete Benchmark Results Wiki →](https://github.com/pingwinator/sysbench/wiki)**

The Wiki includes:
- **[Benchmark Index](https://github.com/pingwinator/sysbench/wiki/Benchmark-Index)** - All 21 systems with detailed specifications
- **[CPU Benchmarks](https://github.com/pingwinator/sysbench/wiki/CPU_BENCHMARKS)** - Single and multi-threaded performance
- **[Memory Benchmarks](https://github.com/pingwinator/sysbench/wiki/MEMORY_BENCHMARKS)** - Read/write performance across memory types
- **[I/O Benchmarks](https://github.com/pingwinator/sysbench/wiki/IO_BENCHMARKS)** - Storage performance results
- **[32-bit Analysis](https://github.com/pingwinator/sysbench/wiki/32BIT_ANALYSIS)** - 32-bit vs 64-bit performance comparison
- **[Individual System Pages](https://github.com/pingwinator/sysbench/wiki/Home#-tested-systems)** - Detailed analysis for each system

## Test Methodology

All benchmarks were conducted using Docker containers to ensure consistency across platforms. Tests were run on real hardware (not emulated).

**Sysbench Version:** 1.0.20 (Debian sid)
**Test Duration:** 10 seconds per test
**Container Runtime:** Docker and Podman

## Reproducibility

To run these benchmarks on your system:

```bash
# Single-threaded CPU test
docker run --rm pingwinator/sysbench:latest

# Multi-threaded CPU test (all cores)
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  cpu --threads=$(nproc) --cpu-max-prime=20000 run

# Memory test
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  memory --threads=$(nproc) --memory-total-size=50G run
```

For complete instructions and additional test scenarios, see the [Wiki Reproducibility Guide](https://github.com/pingwinator/sysbench/wiki/Benchmark-Index#reproducibility).

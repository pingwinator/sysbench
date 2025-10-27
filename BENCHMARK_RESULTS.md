# Sysbench Multi-Architecture Benchmark Results

This document contains comprehensive benchmark results for the `pingwinator/sysbench:latest` Docker image tested across fifteen different systems spanning five architectures: x86_64 (Intel 13th Gen, 8th Gen, Intel Celeron J4025, Intel Celeron J1800, AMD Ryzen Embedded, AMD G-T56N, Intel Pentium N6005, Intel Celeron 1007U), ARM64 (Rockchip RK3588S, Apple M1, Raspberry Pi 5, Raspberry Pi 4, Raspberry Pi 3), ARMv6 (Raspberry Pi Zero W), and RISC-V 64-bit (SiFive).

## Test Environment

All tests were conducted on real hardware running Ubuntu 22.04/24.04 LTS (x86_64, ARM64, RISC-V), macOS 15.0.1 (Apple M1), and Raspbian 10 Buster (ARMv6) using Docker containers. The sysbench Docker image successfully ran on all five architectures without any compatibility issues.

### System Specifications

| System | Board/Platform | Processor | Architecture | Cores/Threads | Max Frequency | L2/L3 Cache | RAM | Memory Type |
|--------|----------------|-----------|--------------|---------------|---------------|-------------|-----|-------------|
| **System 1** | Desktop PC | Intel Core i5-13600 (13th Gen) | x86_64 | 14/20 | 5000 MHz | L3: 24 MB | 32 GB | DDR5-4800 |
| **System 2** | Orange Pi 5 | Rockchip RK3588S | ARM64 | 8 (4×A76+4×A55) | 2400 MHz | L3: 3 MB | 16 GB | LPDDR4X |
| **System 3** | Dell Wyse 3000 Thin Client | Intel Pentium Silver N6005 | x86_64 | 4/4 | 3300 MHz | L3: 4 MB | 16 GB | DDR4-2933 |
| **System 4** | VisionFive 2 | SiFive U74-MC (JH7110) | RISC-V | 4 | 1500 MHz | L2: 2 MB | 8 GB | LPDDR4 |
| **System 5** | ASUS VM40B | Intel Celeron 1007U (Ivy Bridge) | x86_64 | 2/2 | 1500 MHz | L3: 2 MB | 8 GB | DDR3 (?) |
| **System 6** | Lenovo ThinkCentre M720q Tiny | Intel Core i3-8100T (Coffee Lake) | x86_64 | 4/4 | 3100 MHz | L3: 6 MB | 16 GB | DDR4 (?) |
| **System 7** | Raspberry Pi Zero W | Broadcom BCM2835 | ARMv6 | 1/1 | 1000 MHz | L1: 16 KB | 512 MB | LPDDR2 (shared) |
| **System 8** | Raspberry Pi 4 Model B | Broadcom BCM2711 (Cortex-A72) | ARM64 | 4/4 | 1500 MHz | L2: 1 MB | 4 GB | LPDDR4 |
| **System 9** | Raspberry Pi 3 Model B | Broadcom BCM2837 (Cortex-A53) | ARM64 | 4/4 | 1200 MHz | L2: 512 KB | 1 GB | LPDDR2 |
| **System 10** | Raspberry Pi 5 Model B | Broadcom BCM2712 (Cortex-A76) | ARM64 | 4/4 | 2400 MHz | L2: 2 MB | 8 GB | LPDDR4X |
| **System 15** | Mac mini (2020) | Apple M1 | ARM64 | 8 (4×P+4×E) | 3200 MHz | L2: 12 MB | 8 GB | LPDDR4X (Unified) |
| **System 11** | HP t640 Thin Client | AMD Ryzen Embedded R1505G (Zen+) | x86_64 | 2/4 | 2400 MHz | L3: 4 MB | 6 GB | DDR4-2400 |
| **System 12** | Synology DS220+ NAS | Intel Celeron J4025 (Gemini Lake) | x86_64 | 2/2 | 2000 MHz | L2: 4 MB | 10 GB | DDR4-2666 |
| **System 13** | QNAP TS-251+ NAS | Intel Celeron J1800 (Bay Trail) | x86_64 | 2/2 | 2410 MHz | L2: 1 MB | 16 GB | DDR3L |
| **System 14** | Fustro S900/S920 | AMD G-T56N (Ontario/Zacate) | x86_64 | 2/2 | 1650 MHz | L2: 1 MB | 3.4 GB | DDR3 (?) |

---

## CPU Benchmark Results

### Single-Threaded Performance

**Test Command:**
```bash
docker run --rm pingwinator/sysbench:latest
# Default: cpu --threads=1 --cpu-max-prime=20000 run
```

**Results Summary:**

| System | Processor | Events/sec | Avg Latency | Relative Performance |
|--------|-----------|------------|-------------|---------------------|
| System 15 | Apple M1 | **4,046.19** | 0.25 ms | 246% (Fastest ARM) |
| System 1 | Intel Core i5-13600 | **1,641.95** | 0.61 ms | 100% (Fastest x86) |
| System 10 | Cortex-A76 (RPi 5) | 1,013.19 | 0.99 ms | 62% |
| System 2 | Rockchip RK3588S | 979.66 | 1.02 ms | 60% |
| System 3 | Intel Pentium N6005 | 775.24 | 1.29 ms | 47% |
| System 12 | Intel Celeron J4025 | 642.11 | 1.56 ms | 39% |
| System 8 | Cortex-A72 (RPi 4) | 575.31 | 1.74 ms | 35% |
| System 6 | Intel Core i3-8100T | 398.65 | 2.51 ms | 24% |
| System 9 | Cortex-A53 (RPi 3) | 234.15 | 4.26 ms | 14% |
| System 4 | SiFive U74-MC | 198.82 | 5.03 ms | 12% |
| System 11 | AMD Ryzen R1505G | 192.97 | 5.18 ms | 12% |
| System 5 | Intel Celeron 1007U | 161.32 | 6.19 ms | 10% |
| System 13 | Intel Celeron J1800 | 153.20 | 6.52 ms | 9% |
| System 14 | AMD G-T56N | 63.01 | 15.86 ms | 4% |
| System 7 | BCM2835 (RPi Zero W) | 2.91 | 342.13 ms | 0.18% |

**Performance Chart:**
```
Apple M1       ████████████████████████████████████████████████ 4,046 evt/s (246% - NEW CHAMPION!)
i5-13600       ████████████████████ 1,642 evt/s (100%)
RPi 5 (A76)    ████████████▌        1,013 evt/s (62%)
RK3588S        ████████████         980 evt/s   (60%)
Pentium N6005  █████████            775 evt/s   (47%)
Celeron J4025  ████████             642 evt/s   (39%)
RPi 4 (A72)    ███████              575 evt/s   (35%)
i3-8100T       █████                399 evt/s   (24%)
RPi 3 (A53)    ███                  234 evt/s   (14%)
RISC-V U74     ██                   199 evt/s   (12%)
Ryzen R1505G   ██                   193 evt/s   (12%)
Celeron 1007U  ██                   161 evt/s   (10%)
Celeron J1800  ██                   153 evt/s   (9%)
AMD G-T56N     █                    63 evt/s    (4%)
RPi Zero W     ░                    3 evt/s     (0.2%)
```

**Key Findings:**

1. **Intel i5-13600 - Absolute Champion**: Modern Raptor Lake architecture (2023) with hybrid P/E core design demonstrates superior single-threaded performance.

2. **ARM Competitive**: RK3588S outperforms the budget Intel Pentium N6005, proving ARM processors are competitive in server workloads.

3. **Pentium Silver N6005 - Budget Performer**: Despite x86_64 architecture, loses to ARM processor due to weaker specifications (Atom-class CPU).

4. **RISC-V Beats Old x86_64**: RISC-V U74 (199 evt/s) outperforms the 2012-era Celeron 1007U (161 evt/s), showing that old x86_64 processors are slower than emerging architectures!

5. **Celeron 1007U - Legacy Hardware**: 10-year-old Ivy Bridge processor (2012-2013) is the slowest, 10.2x slower than the i5-13600. Still runs modern containers without issues.

6. **Sysbench Compatibility**: Docker image `pingwinator/sysbench:latest` successfully executed on all architectures without issues.

7. **Raspberry Pi Zero W - ARMv6 Legacy**: Single-core BCM2835 (2.91 evt/s) is 564x slower than the i5-13600 and even 55x slower than the old Celeron 1007U. This represents the absolute minimum performance for a usable Linux system, validating ARMv6 support for IoT and embedded devices.

---

### Multi-Threaded Performance

**Test Commands:**
```bash
# Determine optimal thread count for your system
THREADS=$(nproc)

# Intel i5-13600 (20 threads)
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  cpu --threads=20 --cpu-max-prime=20000 run

# Rockchip RK3588S (8 threads)
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  cpu --threads=8 --cpu-max-prime=20000 run

# Intel Pentium N6005 (4 threads)
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  cpu --threads=4 --cpu-max-prime=20000 run

# SiFive U74 (4 threads)
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  cpu --threads=4 --cpu-max-prime=20000 run

# Intel Celeron 1007U (2 threads)
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  cpu --threads=2 --cpu-max-prime=20000 run
```

**Results Summary:**

| System | Processor | Threads | Single-Thread (evt/s) | Multi-Thread (evt/s) | Speedup | Scaling Efficiency |
|--------|-----------|---------|----------------------|----------------------|---------|-------------------|
| System 15 | Apple M1 | 8 | 4,046.19 | **17,651.25** | 4.4x | 55% (Docker Desktop) |
| System 15 | Apple M1 | 8 | 4,046.19 | **14,725.96** | 3.6x | 45% (Apple Container) |
| System 1 | Intel Core i5-13600 | 20 | 1,641.95 | **18,113.55** | 11.0x | 55% |
| System 2 | Rockchip RK3588S | 8 | 979.66 | **5,273.76** | 5.4x | 67% |
| System 10 | Cortex-A76 (RPi 5) | 4 | 1,013.19 | **3,957.99** | 3.9x | 98% |
| System 3 | Intel Pentium N6005 | 4 | 775.24 | **3,077.02** | 4.0x | 99% |
| System 8 | Cortex-A72 (RPi 4) | 4 | 575.31 | **2,078.67** | 3.6x | 90% |
| System 6 | Intel Core i3-8100T | 4 | 398.65 | **1,590.39** | 4.0x | 99% |
| System 9 | Cortex-A53 (RPi 3) | 4 | 234.15 | **808.37** | 3.5x | 86% |
| System 4 | SiFive U74-MC | 4 | 198.82 | **789.96** | 4.0x | 99% |
| System 11 | AMD Ryzen R1505G | 4 | 192.97 | **685.37** | 3.6x | 89% |
| System 12 | Intel Celeron J4025 | 2 | 642.11 | **1,230.64** | 1.9x | 96% |
| System 10 (32-bit) | Cortex-A76 (RPi 5) | 4 | 63.32 | **246.96** | 3.9x | 98% |
| System 5 | Intel Celeron 1007U | 2 | 161.32 | **290.40** | 1.8x | 90% |
| System 13 | Intel Celeron J1800 | 2 | 153.20 | **163.05** | 1.1x | 53% |
| System 14 | AMD G-T56N | 2 | 63.01 | **121.86** | 1.9x | 97% |
| System 12 (32-bit) | Intel Celeron J4025 | 2 | 238.93 | **461.86** | 1.9x | 97% |
| System 13 (32-bit) | Intel Celeron J1800 | 2 | 91.92 | **143.71** | 1.6x | 78% |
| System 11 (32-bit) | AMD Ryzen R1505G | 4 | 192.94 | **685.69** | 3.6x | 89% |

**Absolute Performance Chart:**
```
i5-13600       ████████████████████ 18,113 evt/s (100%)
M1 (Docker)    ████████████████████ 17,651 evt/s (97% - Fastest per-core!)
M1 (Container) ████████████████     14,726 evt/s (81%)
RK3588S        ██████               5,274 evt/s  (29%)
RPi 5 (A76)    ████                 3,958 evt/s  (22%)
Pentium N6005  ████                 3,077 evt/s  (17%)
RPi 4 (A72)    ███                  2,079 evt/s  (11%)
i3-8100T       ██                   1,590 evt/s  (9%)
RPi 3 (A53)    █                    808 evt/s    (4%)
RISC-V U74     █                    790 evt/s    (4%)
Ryzen R1505G   █                    685 evt/s    (4%)
Celeron 1007U  █                    290 evt/s    (2%)
```

**Scaling Efficiency Analysis:**

**Efficiency = (Speedup / Thread Count) × 100%**

#### Perfect Scaling (98-99%):
- **Intel Pentium N6005**: 4.0x speedup on 4 threads = 99% efficiency
- **Intel Core i3-8100T**: 4.0x speedup on 4 threads = 99% efficiency
- **SiFive U74 (RISC-V)**: 4.0x speedup on 4 threads = 99% efficiency
- **Cortex-A76 (Raspberry Pi 5)**: 3.9x speedup on 4 threads = 98% efficiency

These processors show nearly linear scaling! Each core works at full capacity without losses. RPi 5's A76 cores deliver exceptional multi-thread efficiency.

#### Excellent Scaling (86-90%):
- **Cortex-A72 (Raspberry Pi 4)**: 3.6x speedup on 4 threads = 90% efficiency
- **Intel Celeron 1007U**: 1.8x speedup on 2 threads = 90% efficiency
- **AMD Ryzen R1505G**: 3.6x speedup on 4 threads = 89% efficiency (SMT)
- **Cortex-A53 (Raspberry Pi 3)**: 3.5x speedup on 4 threads = 86% efficiency

Simple homogeneous architectures with identical cores achieve excellent scaling. Both Raspberry Pi models (A72 and A53) demonstrate ARM's mature quad-core design with consistent performance across cores.

#### Good Scaling (67%):
- **Rockchip RK3588S**: 5.4x speedup on 8 threads = 67% efficiency

The big.LITTLE architecture loses efficiency due to different core performance (4×A76 fast + 4×A55 slow).

#### Moderate Scaling (55%):
- **Intel i5-13600**: 11.0x speedup on 20 threads = 55% efficiency

Hybrid architecture (6 P-cores + 8 E-cores) and high L3 cache contention reduce efficiency.

**Detailed Analysis:**

**System 1 - Intel i5-13600**
- Threads: 20
- Events/sec: 18,113.55
- Avg latency: 1.10 ms
- Max latency: 17.68 ms (outlier)
- Event distribution: 9,058 ± 1,876 events per thread

Analysis: Large standard deviation (1,876) indicates uneven load. P-cores receive more work than E-cores. Despite 55% efficiency, absolute performance is the best.

**System 2 - Rockchip RK3588S**
- Threads: 8
- Events/sec: 5,273.76
- Avg latency: 1.52 ms
- Max latency: 5.52 ms
- Event distribution: 6,595 ± 2,972 events per thread

Analysis: Huge deviation (2,972) due to big.LITTLE architecture. A76 cores (4×) do ~80% of work, A55 cores (4×) do ~20%. Still excellent absolute performance.

**System 3 - Intel Pentium N6005**
- Threads: 4
- Events/sec: 3,077.02
- Avg latency: 1.30 ms
- Max latency: 22.08 ms (system interrupt)
- Event distribution: 7,694 ± 9 events per thread

Analysis: Nearly perfect distribution (stddev = 9!). All 4 cores are identical (no P/E separation). 99% scaling efficiency.

**System 6 - Intel Core i3-8100T (Coffee Lake, 8th Gen)**
- Threads: 4
- Events/sec: 1,590.39
- Avg latency: 2.52 ms
- Max latency: 13.84 ms
- Event distribution: 3,977 ± 11 events per thread

Analysis: Nearly perfect distribution (stddev = 11). All 4 cores are identical (no P/E separation). 99% scaling efficiency. 8th generation Coffee Lake (2018) with mature architecture demonstrates that homogeneous cores scale better than hybrid designs.

**System 4 - SiFive U74 (RISC-V)**
- Threads: 4
- Events/sec: 789.96
- Avg latency: 5.06 ms
- Max latency: 27.95 ms
- Event distribution: 1,976 ± 15 events per thread

Analysis: Perfect distribution (stddev = 15). All 4 cores are completely symmetrical. 99% scaling efficiency. Slow absolute speed, but excellent scaling.

**Key Findings:**

1. **Intel i5-13600 - King of Absolute Performance**: Even at 55% scaling efficiency, delivers 18,113 events/sec - the absolute record.

2. **Simple Architectures Scale Better**: Pentium and RISC-V with identical cores achieve 99% efficiency vs 55-67% for hybrid architectures.

3. **big.LITTLE Loses Efficiency**: RK3588S shows 67% due to difference between fast A76 and slow A55 cores.

4. **Intel Hybrid P/E Architectures**: Excellent absolute performance, but uneven load on different core types reduces scaling efficiency.

5. **RISC-V Shows Correct Architecture**: Despite low absolute speed, perfect scaling proves clean and symmetrical design.

**Final Rankings:**

**By Absolute Performance:**
1. Intel i5-13600: 18,113 evt/s
2. Rockchip RK3588S: 5,274 evt/s
3. Intel Pentium N6005: 3,077 evt/s
4. Intel Core i3-8100T: 1,590 evt/s
5. SiFive U74-MC: 790 evt/s
6. Intel Celeron 1007U: 290 evt/s

**By Scaling Efficiency:**
1. Intel Pentium N6005: 99%
1. Intel Core i3-8100T: 99%
1. SiFive U74-MC: 99%
4. Intel Celeron 1007U: 90%
5. Rockchip RK3588S: 67%
6. Intel i5-13600: 55%

---

## Memory Benchmark Results

### Memory Write Performance

**Test Commands:**
```bash
# Intel i5-13600 (20 threads, 100GB)
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  memory --threads=20 --memory-total-size=100G run

# Rockchip RK3588S (8 threads, 50GB)
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  memory --threads=8 --memory-total-size=50G run

# Intel Pentium N6005 (4 threads, 50GB)
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  memory --threads=4 --memory-total-size=50G run

# SiFive U74 (4 threads, 20GB)
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  memory --threads=4 --memory-total-size=20G run
```

### Memory Read Performance

**Test Commands:**
```bash
# Same as write tests, but with --memory-oper=read flag
```

**Results Summary:**

| System | Processor | RAM | Memory Type | Write (MiB/s) | Read (MiB/s) | Read/Write Ratio |
|--------|-----------|-----|-------------|---------------|--------------|------------------|
| **System 1** | Intel Core i5-13600 | 32 GB | DDR5-4800 | **18,617** | **104,141** | 5.6x |
| **System 3** | Intel Pentium N6005 | 16 GB | DDR4-2933 | **11,611** | **25,173** | 2.2x |
| **System 15** | Apple M1 (Container) | 8 GB | LPDDR4X (Unified) | **9,277** | **29,623** | 3.2x |
| **System 15** | Apple M1 (Docker) | 8 GB | LPDDR4X (Unified) | **6,682** | **19,804** | 3.0x |
| **System 2** | Rockchip RK3588S | 16 GB | LPDDR4X/5 | **11,463** | **19,457** | 1.7x |
| **System 10** | Cortex-A76 (RPi 5) | 8 GB | LPDDR4X | **8,351** | **15,609** | 1.9x |
| **System 8** | Cortex-A72 (RPi 4) | 4 GB | LPDDR4 | **6,313** | **7,177** | 1.1x |
| **System 12** | Intel Celeron J4025 | 10 GB | DDR4-2666 | **7,011** | **12,548** | 1.8x |
| **System 11** | AMD Ryzen R1505G | 6 GB | DDR4-2400 | **4,249** | **7,140** | 1.7x |
| **System 9** | Cortex-A53 (RPi 3) | 1 GB | LPDDR2 | **3,354** | **4,026** | 1.2x |
| **System 5** | Intel Celeron 1007U | 8 GB | DDR3 (?) | **3,145** | **5,148** | 1.6x |
| **System 13** | Intel Celeron J1800 | 16 GB | DDR3L | **1,965** | **3,226** | 1.6x |
| **System 4** | SiFive U74-MC | 8 GB | DDR4 (?) | **1,761** | **2,385** | 1.4x |
| **System 14** | AMD G-T56N | 3.4 GB | DDR3 (?) | **1,187** | **2,939** | 2.5x |
| **System 7** | BCM2835 (RPi Zero W) | 512 MB | LPDDR2 (shared) | **41.56** | **52.34** | 1.3x |

**Write Performance Chart:**
```
i5-13600       ████████████████████ 18,617 MiB/s (100%)
Pentium N6005  ████████████▌        11,611 MiB/s (62%)
RK3588S        ████████████▍        11,463 MiB/s (62%)
M1 (Container) ██████████            9,277 MiB/s (50%)
RPi 5 (A76)    █████████             8,351 MiB/s (45%)
Celeron J4025  ████████              7,011 MiB/s (38%)
M1 (Docker)    ███████▌              6,682 MiB/s (36%)
RPi 4 (A72)    ███████               6,313 MiB/s (34%)
Ryzen R1505G   █████                 4,249 MiB/s (23%)
RPi 3 (A53)    ████                  3,354 MiB/s (18%)
Celeron 1007U  ████                  3,145 MiB/s (17%)
Celeron J1800  ██                    1,965 MiB/s (11%)
RISC-V U74     █                     1,761 MiB/s (9%)
AMD G-T56N     █                     1,187 MiB/s (6%)
RPi Zero W     ░                        41 MiB/s (0.2%)
```

**Read Performance Chart:**
```
i5-13600       ████████████████████ 104,141 MiB/s (100%)
M1 (Container) ██████                29,623 MiB/s (28%)
Pentium N6005  █████                 25,173 MiB/s (24%)
M1 (Docker)    ████                  19,804 MiB/s (19%)
RK3588S        ████                  19,457 MiB/s (19%)
RPi 5 (A76)    ███                   15,609 MiB/s (15%)
Celeron J4025  ███                   12,548 MiB/s (12%)
RPi 4 (A72)    ██                     7,177 MiB/s (7%)
Ryzen R1505G   ██                     7,140 MiB/s (7%)
Celeron 1007U  █                      5,148 MiB/s (5%)
RPi 3 (A53)    █                      4,026 MiB/s (4%)
Celeron J1800  █                      3,226 MiB/s (3%)
AMD G-T56N     █                      2,939 MiB/s (3%)
RISC-V U74     █                      2,385 MiB/s (2%)
RPi Zero W     ░                         52 MiB/s (0.05%)
```

**Detailed Analysis:**

### System 1: Intel i5-13600 + DDR5-4800

**Specifications:**
- 32 GB DDR5-4800 (dual channel, 2×16GB)
- 20 test threads
- Transferred: 100 GB

**Performance:**
- Write: 18,617 MiB/s (18.2 GB/s)
- Read: 104,141 MiB/s (101.7 GB/s)
- Read/Write Ratio: **5.6x** (read is 5.6 times faster than write)

**Analysis:**
- Incredible read speed thanks to L3 cache (24 MB) and DDR5
- Read completed in 0.98 seconds (!)
- Write completed in 5.5 seconds
- Huge cache keeps much data "hot"
- Dual channel DDR5 running at full capacity

---

### System 3: Dell Wyse 3000 - Intel Pentium N6005 + DDR4-2933

**Specifications:**
- Platform: Dell Wyse 3000 Thin Client
- 16 GB DDR4-2933 (dual channel, 2×8GB)
- 4 test threads
- Transferred: 50 GB

**Performance:**
- Write: 11,611 MiB/s (11.3 GB/s)
- Read: 25,173 MiB/s (24.6 GB/s)
- Read/Write Ratio: **2.2x**

**Analysis:**
- **Surprisingly fast write!** Beat the ARM processor
- Read faster than RK3588S despite DDR4 vs LPDDR4X
- Dual channel DDR4 works more efficiently than LPDDR
- Simpler architecture = lower latency
- Write completed in 4.4 sec, read in 2.0 sec
- Excellent performance for a thin client platform

---

### System 2: Orange Pi 5 - Rockchip RK3588S + LPDDR4X

**Specifications:**
- Board: Orange Pi 5 SBC
- 16 GB LPDDR4X memory
- 8 test threads (4×A76 + 4×A55 cores)
- Transferred: 50 GB

**Performance:**
- Write: 11,463 MiB/s (11.2 GB/s)
- Read: 19,457 MiB/s (19.0 GB/s)
- Read/Write Ratio: **1.7x**

**Analysis:**
- LPDDR4X memory optimized for power efficiency, not maximum speed
- Smaller L3 cache (3 MB) limits read performance
- big.LITTLE architecture (fast A76 + efficient A55 cores) creates uneven memory load
- Write completed in 4.5 sec, read in 2.6 sec
- R/W ratio closer to 1 = more balanced memory architecture

---

### System 4: VisionFive 2 - SiFive U74-MC + LPDDR4

**Specifications:**
- Board: StarFive VisionFive 2 (JH7110 SoC)
- 8 GB LPDDR4 memory
- 4 test threads (SiFive U74 quad-core @ 1.5 GHz)
- Transferred: 20 GB

**Performance:**
- Write: 1,761 MiB/s (1.7 GB/s)
- Read: 2,385 MiB/s (2.3 GB/s)
- Read/Write Ratio: **1.4x**

**Analysis:**
- **Critically slow memory** (10-40 times slower than other systems)
- Probable causes:
  - Single channel LPDDR4 configuration or narrow data bus
  - Lack of optimized memory controllers for RISC-V
  - Immature RISC-V memory subsystem architecture in JH7110 SoC
  - Lower memory bandwidth compared to dual-channel configurations
- Write took the **ENTIRE** 10-second limit (didn't complete)
- R/W ratio close to 1 = simple architecture without aggressive caching
- Memory performance is the primary bottleneck for RISC-V platform

---

### System 6: Lenovo ThinkCentre M720q Tiny - Intel Core i3-8100T + DDR4

**Specifications:**
- Platform: Lenovo ThinkCentre M720q Tiny (Coffee Lake, 8th Gen, 2018)
- 16 GB DDR4 memory (likely dual channel, 2×8GB)
- 4 test threads
- Transferred: 50 GB

**Performance:**
- Write: 7,824 MiB/s (7.6 GB/s)
- Read: 25,138 MiB/s (24.5 GB/s)
- Read/Write Ratio: **3.2x**

**Analysis:**
- Coffee Lake architecture (2018) with mature 14nm++ process
- Exceptional read performance, matching the Pentium N6005 despite older generation
- Moderate write speed, about 68% of Pentium N6005
- Higher R/W ratio (3.2x) indicates aggressive L3 cache optimization (6MB)
- Write completed in 6.5 sec, read in 2.0 sec
- Tiny form factor platform with excellent memory performance
- Ideal balance between size, power consumption, and performance

---

### System 5: ASUS VM40B - Intel Celeron 1007U + DDR3

**Specifications:**
- Platform: ASUS VM40B Thin Client (Ivy Bridge era, 2012-2013)
- 8 GB DDR3 memory
- 2 test threads
- Transferred: 20 GB

**Performance:**
- Write: 3,145 MiB/s (3.1 GB/s)
- Read: 5,148 MiB/s (5.0 GB/s)
- Read/Write Ratio: **1.6x**

**Analysis:**
- **Old but balanced**: 10-year-old processor with DDR3 memory shows moderate performance
- Better than RISC-V but significantly slower than modern systems
- R/W ratio of 1.6x indicates balanced memory subsystem
- Write completed in 6.5 sec, read in 4.0 sec
- Limited by old DDR3 memory and small L3 cache (2 MB)
- Still 1.8x faster write and 2.2x faster read than RISC-V
- Legacy thin client still running modern containerized workloads

---

### System 7: Raspberry Pi Zero W - Broadcom BCM2835 + LPDDR2

**Specifications:**
- Platform: Raspberry Pi Zero W (2015)
- 512 MB LPDDR2 memory (shared with VideoCore IV GPU)
- 1 test thread (BCM2835 single-core @ 1 GHz)
- Transferred: 1 GB
- Architecture: ARMv6 (32-bit)

**Performance:**
- Write: 41.56 MiB/s (0.04 GB/s)
- Read: 52.34 MiB/s (0.05 GB/s)
- Read/Write Ratio: **1.3x**

**Analysis:**
- **Extremely slow memory** - 448x slower write and 1,990x slower read than i5-13600
- **Reasons for low performance**:
  - Single-channel LPDDR2 with very narrow memory bus
  - Memory shared with GPU (VideoCore IV), reducing available bandwidth
  - Single-core ARMv6 architecture from 2011 (BCM2835 is reused from original Raspberry Pi)
  - Only 512 MB total memory (430 MB available after GPU allocation)
  - 16 KB L1 cache only - no L2 or L3 cache
- R/W ratio of 1.3x indicates minimal caching and simple memory architecture
- Despite extremely low performance, successfully runs modern Docker containers
- **Best use case**: IoT devices, sensor nodes, learning projects, legacy ARMv6 software testing
- Write completed in 10 sec, read in 10 sec (both hit time limit)
- **Important**: Demonstrates that even the slowest ARM platform can run containerized benchmarks

---

### System 8: Raspberry Pi 4 Model B - Broadcom BCM2711 (Cortex-A72) + LPDDR4

**Specifications:**
- Platform: Raspberry Pi 4 Model B Rev 1.2 (2019)
- 4 GB LPDDR4 memory
- 4 test threads (Cortex-A72 quad-core @ 1.5 GHz)
- Transferred: 10 GB
- Architecture: ARM64 (aarch64)

**Performance:**
- Write: 6,313.14 MiB/s (6.2 GB/s)
- Read: 7,176.61 MiB/s (7.0 GB/s)
- Read/Write Ratio: **1.1x**

**Analysis:**
- **Solid mid-range performance** - 3.0x slower write and 14.5x slower read than i5-13600
- **Much better than RPi Zero W**: 152x faster write, 137x faster read
- **Reasons for performance**:
  - LPDDR4 memory with 32-bit or 64-bit bus width
  - Cortex-A72 cores are mature and efficient ARM design (2015)
  - 1 MB L2 cache shared across all cores
  - Quad-core homogeneous design (all cores identical)
  - 4 GB RAM provides adequate headroom for benchmarks
- R/W ratio of 1.1x is the best among all systems (except RPi Zero W at 1.3x)
- Excellent memory balance indicates simple, efficient memory controller
- Write completed in 1.6 sec, read in 1.4 sec
- **Best use case**: Home server, NAS, Kubernetes edge nodes, development platform, learning ARM64
- Demonstrates that Raspberry Pi 4 is a capable ARM64 platform for light server workloads
- Successfully ran sysbench via Podman (Docker alternative)

---

### System 10: Raspberry Pi 5 Model B - Broadcom BCM2712 (Cortex-A76) + LPDDR4X

**Specifications:**
- Platform: Raspberry Pi 5 Model B Rev 1.0 (2023)
- 8 GB LPDDR4X memory
- 4 test threads (Cortex-A76 quad-core @ 2.4 GHz)
- Transferred: 20 GB
- Architecture: ARM64 (aarch64)

**Performance:**
- Write: 8,350.54 MiB/s (8.2 GB/s)
- Read: 15,608.54 MiB/s (15.2 GB/s)
- Read/Write Ratio: **1.9x**

**Analysis:**
- **Excellent ARM performance** - 2.2x slower write and 6.7x slower read than i5-13600
- **Much better than RPi 4**: 1.3x faster write, 2.2x faster read
- **Major improvements over RPi 4**:
  - Newer Cortex-A76 cores (2018) vs A72 cores (2015)
  - Higher clock speed: 2.4 GHz vs 1.5 GHz (60% faster)
  - LPDDR4X memory vs LPDDR4 (more efficient, lower power)
  - 2 MB L2 cache vs 1 MB (2x larger cache)
  - 8 GB RAM vs 4 GB (2x more memory)
- **CPU performance**: Single-thread 1013 evt/s (76% faster than RPi 4's 575 evt/s)
- **Multi-thread scaling**: 98% efficiency with 3.9x speedup on 4 cores (nearly perfect)
- R/W ratio of 1.9x indicates better cache optimization than RPi 4 (1.1x) but still balanced
- Write completed in 2.5 sec, read in 1.3 sec
- **Best use case**: Home server, NAS, Kubernetes nodes, ARM64 development, AI/ML edge computing, desktop replacement
- Demonstrates that Raspberry Pi 5 is a significant upgrade, suitable for medium workloads
- Successfully ran sysbench via Podman
- **Verdict**: RPi 5 is the fastest single-board computer in the Raspberry Pi family, delivering performance competitive with low-end x86 systems

---

### System 9: Raspberry Pi 3 Model B - Broadcom BCM2837 (Cortex-A53) + LPDDR2

**Specifications:**
- Platform: Raspberry Pi 3 Model B Rev 1.2 (2016)
- 1 GB LPDDR2 memory
- 4 test threads (Cortex-A53 quad-core @ 1.2 GHz)
- Transferred: 3 GB
- Architecture: ARM64 (aarch64)

**Performance:**
- Write: 3,354.06 MiB/s (3.3 GB/s)
- Read: 4,026.03 MiB/s (3.9 GB/s)
- Read/Write Ratio: **1.2x**

**Analysis:**
- **Mid-range performance** - 5.6x slower write and 25.9x slower read than i5-13600
- **Better than expected for LPDDR2**: Matches 10-year-old Celeron 1007U despite older memory technology
- **Much better than RPi Zero W**: 81x faster write, 77x faster read
- **Slower than RPi 4**: 1.9x slower write, 1.8x slower read
- **Reasons for performance**:
  - LPDDR2 memory with limited bandwidth compared to LPDDR4
  - Cortex-A53 cores are efficient but slower than A72 (2012 design vs 2015)
  - 512 KB L2 cache (half of RPi 4's 1 MB)
  - Quad-core homogeneous design provides good multi-threading (86% efficiency)
  - 1 GB RAM adequate for basic server workloads
- R/W ratio of 1.2x is excellent - second best balance after RPi 4 (1.1x)
- Write completed in 0.9 sec, read in 0.8 sec
- **Best use case**: Budget home server, learning ARM64, lightweight NAS, retro gaming, educational projects
- Demonstrates that older Raspberry Pi models remain capable for basic containerized workloads
- Successfully ran sysbench via Podman

---

### System 11: HP t640 Thin Client - AMD Ryzen Embedded R1505G + DDR4-2400

**Specifications:**
- Platform: HP t640 Thin Client (Zen+ architecture, 2019)
- 6 GB DDR4-2400 (dual channel, likely 4GB + 2GB)
- 2 test threads (2 cores, 4 threads @ 2.4 GHz)
- Transferred: 10 GB
- Architecture: x86_64 (AMD64)

**Performance:**
- Write: 4,249 MiB/s (4.1 GB/s)
- Read: 7,140 MiB/s (7.0 GB/s)
- Read/Write Ratio: **1.7x**

**Analysis:**
- **Mid-range performance** - 4.4x slower write and 14.6x slower read than i5-13600
- **Better than RPi 3 and older systems**: 1.3x faster write, 1.8x faster read than RPi 3
- **Slower than RPi 4**: 0.67x write, 1.0x read compared to RPi 4
- **Reasons for performance**:
  - DDR4-2400 dual-channel memory (slower than DDR4-2666/2933)
  - AMD Zen+ architecture with efficient 12nm process
  - 1 MB L2 cache (512 KB per core)
  - Only 2 cores tested (has 4 threads via SMT, but sysbench used 2 threads)
  - 6 GB RAM in asymmetric configuration (4GB + 2GB)
- R/W ratio of 1.7x indicates balanced memory subsystem, similar to RK3588S
- Write completed in 2.4 sec, read in 1.4 sec
- **Unique finding**: ZERO performance loss in 32-bit mode (192.94 vs 192.97 evt/s) - only tested processor with perfect 32-bit compatibility
- **CPU performance**: Single-thread 192.97 evt/s, multi-thread 685.37 evt/s (3.6x speedup, 89% efficiency)
- **Best use case**: Thin client, VDI, budget desktop, home office, legacy software compatibility
- AMD's excellent x86 compatibility makes it ideal for running 32-bit legacy applications
- Successfully ran sysbench via Docker with sudo

---

### System 12: Synology DS220+ NAS - Intel Celeron J4025 + DDR4-2666

**Specifications:**
- Platform: Synology DS220+ 2-bay NAS (Gemini Lake Refresh, 2019)
- 10 GB DDR4-2666 (dual channel, 4GB base + 6GB expansion)
- 2 test threads (2 cores @ 2.0 GHz)
- Transferred: 10 GB
- Architecture: x86_64
- Operating System: Synology DSM 6.2.x

**Performance:**
- Write: 7,011 MiB/s (6.8 GB/s)
- Read: 12,548 MiB/s (12.3 GB/s)
- Read/Write Ratio: **1.8x**

**Analysis:**
- **Good NAS performance** - 2.7x slower write and 8.3x slower read than i5-13600
- **Better than AMD Ryzen**: 1.6x faster write, 1.8x faster read than HP t640
- **Comparable to RPi 4**: 1.1x faster write, 1.7x faster read than RPi 4
- **Reasons for performance**:
  - DDR4-2666 dual-channel memory (faster than R1505G's DDR4-2400)
  - Gemini Lake Refresh with improved 14nm process (2019)
  - 4 MB L2 cache shared across 2 cores
  - Dual-core homogeneous design
  - 10 GB RAM provides good headroom for NAS operations
- R/W ratio of 1.8x indicates balanced memory subsystem optimized for NAS workloads
- Write completed in 1.5 sec, read in 0.8 sec
- **CPU performance**: Single-thread 642.11 evt/s (3.3x faster than R1505G), multi-thread 1,230.64 evt/s (1.9x speedup, 96% scaling)
- **32-bit performance loss**: -63% CPU loss (642→239 evt/s), -62% memory read loss
- **Best use case**: Home NAS, file server, media server, Docker host, VM host (DSM supports virtual machines)
- Excellent balance of performance, power efficiency, and NAS-specific features
- Successfully ran sysbench via Docker with sudo (Synology DSM 6.2.x)
- **NAS-specific advantage**: Synology DSM provides excellent software ecosystem with packages and Docker support

---

### System 13: QNAP TS-251+ NAS - Intel Celeron J1800 + DDR3L

**Specifications:**
- Platform: QNAP TS-251+ 2-bay NAS (Bay Trail, 2013)
- 16 GB DDR3L memory (likely dual channel, 2×8GB)
- 2 test threads (2 cores @ 2.41 GHz)
- Transferred: 10 GB
- Architecture: x86_64
- Operating System: QNAP QTS with Container Station

**Performance:**
- Write: 1,965 MiB/s (1.9 GB/s)
- Read: 3,226 MiB/s (3.1 GB/s)
- Read/Write Ratio: **1.6x**

**Analysis:**
- **Older NAS with limited performance** - 9.5x slower write and 32.3x slower read than i5-13600
- **Slower than RISC-V in write**: 1.1x faster write, 1.4x faster read than VisionFive 2
- **Slower than all ARM SBCs except RPi Zero**: Even RPi 3 is 1.7x faster write, 1.2x faster read
- **Reasons for performance**:
  - **Old DDR3L memory** (lower voltage variant, 2013 era)
  - Bay Trail architecture from 2013 with outdated 22nm process
  - Only 1 MB L2 cache total (512 KB per core - very small)
  - Dual-core design with poor multi-thread scaling (only 1.1x speedup!)
  - Despite 16 GB RAM, memory bandwidth is severely limited
- R/W ratio of 1.6x indicates balanced but slow memory subsystem
- Write completed in 5.2 sec, read in 3.2 sec
- **CPU performance**: Single-thread 153.20 evt/s (SLOWEST x86 tested), multi-thread 163.05 evt/s (1.1x speedup, **53% efficiency** - WORST SCALING)
- **32-bit performance loss**: -40% CPU loss (153→92 evt/s), but better multi-thread scaling in 32-bit (1.6x vs 1.1x)
- **Critical findings**:
  - Worst multi-thread scaling efficiency (53%) among all tested systems
  - Even single-thread performance is slower than 10-year-old Celeron 1007U (153 vs 161 evt/s)
  - Bay Trail architecture has severe bottlenecks preventing effective use of both cores
- **Best use case**: Budget NAS, file storage, light media serving, legacy hardware repurposing
- **Recommendation**: Consider upgrading to newer NAS hardware - even budget ARM SBCs (RPi 4) offer better performance
- Successfully ran sysbench via Docker (QNAP Container Station at `/share/CACHEDEV1_DATA/.qpkg/container-station/bin/docker`)
- **NAS-specific note**: QNAP QTS provides good software features, but hardware is severely outdated (11+ years old)

---

### System 14: Fustro S900/S920 - AMD G-T56N + DDR3

**Specifications:**
- Platform: Fustro S900/S920 fanless mini PC (Ontario/Zacate APU, 2011)
- 3.4 GB DDR3 memory
- 2 test threads (2 cores @ 0.825-1.65 GHz, dynamic frequency)
- Transferred: 10 GB
- Architecture: x86_64 (AMD64)
- Operating System: Ubuntu 24.04.3 LTS

**Performance:**
- Write: 1,187 MiB/s (1.16 GB/s)
- Read: 2,939 MiB/s (2.87 GB/s)
- Read/Write Ratio: **2.5x**

**Analysis:**
- **SLOWEST x86_64 system tested** - 15.7x slower write and 35.4x slower read than i5-13600
- **Slower than RISC-V**: Only 0.67x write speed of VisionFive 2 (1.19 vs 1.76 GB/s)
- **Slower than all ARM except RPi Zero**: RPi 3 is 2.8x faster write, 1.4x faster read
- **CPU performance**: Single-thread 63.01 evt/s (SLOWEST x86_64, even slower than QNAP by 2.4x), multi-thread 121.86 evt/s (1.9x speedup, **97% efficiency**)
- **Reasons for poor performance**:
  - **AMD Bobcat microarchitecture from 2011** - first generation AMD APU (Ontario/Zacate)
  - Very low clock speed: 825 MHz min, 1650 MHz max (dynamic scaling)
  - Only 1 MB L2 cache total (512 KB per core - tiny)
  - DDR3 memory with very limited bandwidth
  - Low-power design optimized for power efficiency, not performance (18W TDP)
  - Integrated Radeon HD 6250 GPU shares memory bandwidth
- R/W ratio of 2.5x indicates moderate caching despite low performance
- Write completed in 8.6 sec, read in 3.5 sec
- **32-bit performance**: -8.4% CPU loss (63→58 evt/s), -51% memory read loss (2.9→1.4 GB/s)
- **Excellent multi-thread scaling**: 97% efficiency (1.9x on 2 cores) despite terrible absolute performance
- **Critical findings**:
  - SLOWEST x86_64 CPU ever tested - 26x slower than i5-13600
  - Even slower than 14-year-old RISC-V development board in memory write
  - First-generation AMD APU (2011) shows how far AMD has come with Zen architectures
  - Proves that Bobcat microarchitecture was severely limited even when new
- **Best use case**: Ultra-low-power applications, fanless systems, legacy x86 compatibility testing, e-waste reduction
- **Recommendation**: Replace immediately with ANY modern hardware - even RPi 3 (2016) is significantly faster
- Successfully ran sysbench via Docker with sudo
- **Historical note**: AMD G-T56N represents AMD's first APU generation, predating Ryzen by 6 years. Modern AMD Ryzen R1505G (System 11) is 3.1x faster in single-thread performance.

---

### System 15: Mac mini (2020) - Apple M1 + LPDDR4X Unified Memory

**Specifications:**
- Platform: Mac mini (2020)
- 8 GB LPDDR4X Unified Memory (shared CPU/GPU, 128-bit bus)
- 8 test threads (4×Firestorm P-cores @ 3.2 GHz + 4×Icestorm E-cores @ 2.0 GHz)
- Transferred: 20 GB
- Architecture: ARM64 (aarch64)
- Operating System: macOS 26.0.1 (15.0.1)
- **Two container platforms tested**: Apple Container framework and Docker Desktop

**Performance (Apple Container):**
- Write: 9,277 MiB/s (9.1 GB/s)
- Read: 29,623 MiB/s (28.9 GB/s)
- Read/Write Ratio: **3.2x**

**Performance (Docker Desktop):**
- Write: 6,682 MiB/s (6.5 GB/s)
- Read: 19,804 MiB/s (19.3 GB/s)
- Read/Write Ratio: **3.0x**

**Analysis:**

**CPU Performance:**
- **Single-thread: 4,046 evt/s - NEW CHAMPION!** (246% of i5-13600, 173% faster)
- **Multi-thread (Docker Desktop): 17,651 evt/s** - 97% of i5-13600 with only 8 cores vs 20!
- **Multi-thread (Apple Container): 14,726 evt/s** - 81% of i5-13600
- **Speedup: 4.4x (Docker), 3.6x (Container)** - Efficiency: 55% (Docker), 45% (Container)
- **Per-core performance dominance**: M1 delivers 2.46x better single-thread than Intel's flagship i5-13600

**Memory Performance:**
- **Apple Container is 39% faster in writes** (9.3 vs 6.7 GB/s)
- **Apple Container is 50% faster in reads** (28.9 vs 19.3 GB/s)
- **2.0x slower write than i5-13600** (9.1 vs 18.2 GB/s), but only with Apple Container
- **3.5x slower read than i5-13600** (28.9 vs 101.7 GB/s), but still competitive
- **Beats Pentium N6005 in reads with Apple Container** (28.9 vs 24.6 GB/s)

**Container Platform Comparison:**
- **Docker Desktop**: 20% faster multi-thread CPU, but 39% slower memory writes
- **Apple Container**: 39-50% faster memory operations, more stable single-thread (±0.07% variance)
- **Docker Desktop**: More stable multi-thread (±3.3% variance vs ±6.5%)
- **Recommendation**: Use Apple Container for memory-intensive workloads, Docker Desktop for CPU-bound multi-threaded tasks

**x86_64 Emulation via Rosetta 2:**
- **Single-thread: 2,953-2,961 evt/s** (both platforms identical)
- **Performance loss: Only 27%** - Rosetta 2 is remarkably efficient!
- **Memory read (Docker): 17.7 GB/s** - Still competitive with native ARM on other platforms

**Reasons for Outstanding Performance:**
- **Apple Silicon Architecture**: 5nm process, custom ARM cores (Firestorm/Icestorm)
- **Unified Memory**: Zero-copy between CPU/GPU, 128-bit bus width, up to 68 GB/s theoretical bandwidth
- **Massive caches**: 12 MB L2 cache total (8 MB for P-cores, 4 MB for E-cores)
- **big.LITTLE design**: 4×P-cores (3.2 GHz) for performance + 4×E-cores (2.0 GHz) for efficiency
- **Advanced memory controller**: Optimized for LPDDR4X with low latency and high bandwidth
- **Rosetta 2 efficiency**: Ahead-of-time translation with dynamic optimization

**Key Findings:**
1. **M1 is the single-thread CHAMPION** - 2.46x faster than Intel i5-13600
2. **Nearly matches i5-13600 in multi-thread** despite having 8 cores vs 20 (60% fewer cores!)
3. **Apple Container has superior memory performance** - Use for memory-bound workloads
4. **Docker Desktop has superior CPU performance** - Use for compute-bound workloads
5. **Rosetta 2 is remarkably efficient** - Only 27% performance loss for x86_64 emulation
6. **Unified Memory Architecture wins** - Zero-copy sharing with GPU provides flexibility
7. **ARM architecture dominance** - M1 proves ARM can outperform x86 in both efficiency and performance

**Best use case**: Development workstation, content creation, Xcode builds, ARM64 testing, Docker development, virtualization, AI/ML with GPU acceleration

**Verdict**: Apple M1 Mac mini is the most efficient system tested, delivering desktop-class performance with laptop power consumption. The combination of exceptional single-thread performance, competitive multi-thread performance, and low power consumption makes it an outstanding choice for developers and content creators.

---

### Memory Type Comparison

| Memory Type | Processor | Platform | Write | Read | Overall Rating |
|------------|-----------|----------|-------|------|----------------|
| DDR5-4800 | i5-13600 | Desktop PC | 18.2 GB/s | 101.7 GB/s | ⭐⭐⭐⭐⭐ |
| DDR4-2933 | Pentium N6005 | Dell Wyse 3000 | 11.3 GB/s | 24.6 GB/s | ⭐⭐⭐⭐ |
| LPDDR4X | RK3588S | Orange Pi 5 | 11.2 GB/s | 19.0 GB/s | ⭐⭐⭐ |
| LPDDR4X Unified | Apple M1 | Mac mini (Container) | 9.1 GB/s | 28.9 GB/s | ⭐⭐⭐⭐ (Memory) |
| LPDDR4X Unified | Apple M1 | Mac mini (Docker) | 6.5 GB/s | 19.3 GB/s | ⭐⭐⭐ (Memory) |
| LPDDR4X | Cortex-A76 | Raspberry Pi 5 | 8.2 GB/s | 15.2 GB/s | ⭐⭐⭐ |
| DDR4 | i3-8100T | ThinkCentre M720q | 7.6 GB/s | 24.5 GB/s | ⭐⭐⭐⭐ |
| DDR4-2666 | Celeron J4025 | Synology DS220+ | 6.8 GB/s | 12.3 GB/s | ⭐⭐⭐ |
| LPDDR4 | Cortex-A72 | Raspberry Pi 4 | 6.2 GB/s | 7.0 GB/s | ⭐⭐⭐ |
| DDR4-2400 | Ryzen R1505G | HP t640 | 4.1 GB/s | 7.0 GB/s | ⭐⭐ |
| LPDDR2 | Cortex-A53 | Raspberry Pi 3 | 3.3 GB/s | 3.9 GB/s | ⭐⭐ |
| DDR3 | Celeron 1007U | ASUS VM40B | 3.1 GB/s | 5.0 GB/s | ⭐⭐ |
| DDR3L | Celeron J1800 | QNAP TS-251+ | 1.9 GB/s | 3.1 GB/s | ⭐ |
| LPDDR4 | SiFive U74 | VisionFive 2 | 1.7 GB/s | 2.3 GB/s | ⭐ |
| DDR3 | AMD G-T56N | Fustro S900/S920 | 1.2 GB/s | 2.9 GB/s | ⭐ |
| LPDDR2 | BCM2835 | Raspberry Pi Zero W | 0.04 GB/s | 0.05 GB/s | ⚠️ (IoT only) |

---

### Key Findings

1. **DDR5 Dominates in Read Performance**: i5-13600 shows 101.7 GB/s thanks to combination of DDR5, huge L3 cache (24MB), and 20 threads.

2. **Pentium Surprises**: Despite budget status, DDR4-2933 in dual channel delivers excellent performance, beating LPDDR memory in ARM.

3. **LPDDR Loses to DDR4 in Throughput**: RK3588S with LPDDR memory is slower than Pentium with regular DDR4.

4. **Read/Write Ratio Shows Cache Architecture**:
   - **i5-13600 (5.6x)**: Huge L3 cache aggressively caches reads
   - **Pentium (2.2x)**: Moderate L3 cache (4MB)
   - **RK3588S (1.7x)**: Small L3 (3MB)
   - **RISC-V (1.4x)**: Minimal caching

5. **RISC-V Critically Slow**: Memory subsystem is the weakest link in RISC-V platform. 10x slower than other systems!

6. **Thread Count Matters, But Not Linearly**:
   - i5-13600 with 20 threads is not 5x faster than 4-thread Pentium
   - Bottleneck at memory bandwidth level

---

### Final Memory Rankings

**By Write Speed:**
1. Intel i5-13600 (DDR5): 18.2 GB/s
2. Intel Pentium N6005 (DDR4): 11.3 GB/s
3. Rockchip RK3588S (LPDDR4X): 11.2 GB/s
4. Apple M1 (LPDDR4X Unified, Container): 9.1 GB/s
5. Cortex-A76/RPi 5 (LPDDR4X): 8.2 GB/s
6. Intel Core i3-8100T (DDR4): 7.6 GB/s
7. Intel Celeron J4025 (DDR4-2666): 6.8 GB/s
8. Apple M1 (LPDDR4X Unified, Docker): 6.5 GB/s
9. Cortex-A72/RPi 4 (LPDDR4): 6.2 GB/s
10. AMD Ryzen R1505G (DDR4-2400): 4.1 GB/s
11. Cortex-A53/RPi 3 (LPDDR2): 3.3 GB/s
12. Intel Celeron 1007U (DDR3): 3.1 GB/s
13. Intel Celeron J1800 (DDR3L): 1.9 GB/s
14. SiFive U74 (LPDDR4): 1.7 GB/s
15. AMD G-T56N (DDR3): 1.2 GB/s
16. BCM2835 (LPDDR2): 0.04 GB/s

**By Read Speed:**
1. Intel i5-13600 (DDR5): 101.7 GB/s
2. Apple M1 (LPDDR4X Unified, Container): 28.9 GB/s
3. Intel Pentium N6005 (DDR4): 24.6 GB/s
4. Intel Core i3-8100T (DDR4): 24.5 GB/s
5. Apple M1 (LPDDR4X Unified, Docker): 19.3 GB/s
6. Rockchip RK3588S (LPDDR4X): 19.0 GB/s
7. Cortex-A76/RPi 5 (LPDDR4X): 15.2 GB/s
8. Intel Celeron J4025 (DDR4-2666): 12.3 GB/s
9. AMD Ryzen R1505G (DDR4-2400): 7.0 GB/s
10. Cortex-A72/RPi 4 (LPDDR4): 7.0 GB/s
11. Intel Celeron 1007U (DDR3): 5.0 GB/s
12. Cortex-A53/RPi 3 (LPDDR2): 3.9 GB/s
13. Intel Celeron J1800 (DDR3L): 3.1 GB/s
14. AMD G-T56N (DDR3): 2.9 GB/s
15. SiFive U74 (LPDDR4): 2.3 GB/s
16. BCM2835 (LPDDR2): 0.05 GB/s

**By Balance (R/W ratio closer to 1 = better):**
1. Cortex-A72/RPi 4: 1.1x (best balanced memory subsystem)
2. Cortex-A53/RPi 3: 1.2x (excellent balance for LPDDR2)
3. BCM2835 (RPi Zero W): 1.3x (extremely simple, minimal caching)
4. SiFive U74: 1.4x (simple but balanced)
5. Intel Celeron 1007U: 1.6x (old but balanced)
6. Intel Celeron J1800: 1.6x (balanced but slow DDR3L)
7. Rockchip RK3588S: 1.7x
8. AMD Ryzen R1505G: 1.7x (balanced budget AMD system)
9. Intel Celeron J4025: 1.8x (balanced NAS optimized)
10. Cortex-A76/RPi 5: 1.9x (good balance with moderate caching)
11. Intel Pentium N6005: 2.2x
12. AMD G-T56N: 2.5x (low-power APU with moderate caching)
13. Apple M1 (Docker): 3.0x (moderate caching with Docker)
14. Apple M1 (Container): 3.2x (moderate caching with Apple Container)
15. Intel Core i3-8100T: 3.2x
16. Intel i5-13600: 5.6x (optimized for read)

---

## Overall Conclusions

### Platform-Specific Insights

**Apple Mac mini (2020) - Apple M1 (ARM64)**
- Platform: Mac mini (2020) with Apple Silicon
- **NEW SINGLE-THREAD CHAMPION**: 4,046 evt/s (246% of i5-13600, 2.46x faster!)
- Multi-thread performance: 17,651 evt/s (Docker Desktop) - 97% of i5-13600 with only 8 cores vs 20!
- Memory performance: 9.3/28.9 GB/s (Apple Container) or 6.5/19.3 GB/s (Docker Desktop)
- Hybrid architecture: 4×Firestorm P-cores @ 3.2 GHz + 4×Icestorm E-cores @ 2.0 GHz
- Unified Memory Architecture: 8 GB LPDDR4X shared between CPU/GPU with zero-copy
- Massive L2 cache: 12 MB total (8 MB for P-cores, 4 MB for E-cores)
- **Container platform comparison**:
  - Apple Container: 39-50% faster memory, more stable single-thread (±0.07% variance)
  - Docker Desktop: 20% faster multi-thread CPU, more stable multi-thread (±3.3% variance)
- **Rosetta 2 x86_64 emulation**: Only 27% performance loss - remarkable efficiency!
- Multi-thread scaling: 55% (Docker) / 45% (Container) due to P/E core differences
- **Key achievements**:
  - Outperforms Intel i5-13600 by 146% in single-thread (the flagship Intel chip!)
  - Nearly matches i5-13600 in multi-thread despite 60% fewer cores
  - Proves ARM can dominate x86 in both efficiency AND performance
  - Unified Memory provides flexibility for CPU/GPU workloads
- Best choice for: Development workstations, content creation, Xcode builds, ARM64 testing, Docker development, AI/ML, virtualization
- **Verdict**: Apple M1 is the most efficient processor tested, delivering desktop-class performance with laptop power consumption. The single-thread performance dominance proves Apple Silicon's architectural superiority.

**Intel Core i5-13600 (13th Gen, Raptor Lake)**
- Absolute multi-thread performance champion (second in single-thread to Apple M1)
- Modern hybrid architecture (P+E cores) delivers exceptional single-thread performance
- DDR5 memory provides massive read bandwidth (101.7 GB/s)
- Moderate multi-thread scaling (55%) due to heterogeneous cores
- Best choice for: High-performance computing, demanding workloads

**Orange Pi 5 - Rockchip RK3588S (ARM64)**
- Excellent overall performance, competitive with x86_64
- big.LITTLE architecture (4×Cortex-A76 + 4×Cortex-A55) provides good power efficiency
- Beats budget x86_64 processors in single-threaded tasks
- Good multi-thread scaling (67%) considering core heterogeneity
- LPDDR4X memory provides good bandwidth for SBC platform
- Best choice for: ARM servers, energy-efficient computing, embedded systems, home automation

**Dell Wyse 3000 - Intel Pentium Silver N6005 (Jasper Lake)**
- Thin client with surprisingly good performance
- Perfect multi-thread scaling (99%) thanks to homogeneous cores
- DDR4 dual-channel memory performs better than expected
- Beats Orange Pi 5 in memory read performance despite being a budget platform
- Best choice for: Thin clients, NAS, mini PCs, budget servers, home labs, VDI workloads

**ASUS VM40B - Intel Celeron 1007U (Ivy Bridge, 2012-2013)**
- 10-year-old legacy thin client still running modern containers
- Slowest single-thread performance, even slower than RISC-V
- Good multi-thread scaling (90%) despite old architecture
- DDR3 memory limits performance significantly
- Balanced memory subsystem (1.6x R/W ratio)
- Best choice for: Legacy hardware repurposing, very light workloads, e-waste reduction
- Recommendation: Upgrade if possible - any modern processor is 5-10x faster

**VisionFive 2 - SiFive U74-MC (RISC-V)**
- Board: StarFive VisionFive 2 with JH7110 SoC
- Emerging architecture with excellent architectural design
- Perfect multi-thread scaling (99%) shows symmetrical core design
- Critical weakness: Memory subsystem is 10-40x slower than competitors
- LPDDR4 memory limited by single-channel configuration and immature memory controller
- Outperforms 10-year-old x86_64 processors (Celeron 1007U) in CPU performance
- Best choice for: RISC-V development, experimentation, research, educational purposes

**Raspberry Pi 4 Model B - Broadcom BCM2711 (Cortex-A72)**
- Board: Raspberry Pi 4 Model B Rev 1.2 (2019)
- Quad-core ARM64 Cortex-A72 processor (1.5 GHz)
- Solid mid-range performance: 35% of i5-13600 single-thread, 11% multi-thread
- Memory performance: 6.2 GB/s write, 7.0 GB/s read - best balanced system (1.1x R/W ratio)
- 4 GB LPDDR4 RAM provides adequate memory for server workloads
- Excellent multi-thread scaling (90%) thanks to homogeneous quad-core design
- Successfully ran sysbench via Podman container runtime
- Best choice for: Home servers, NAS, Kubernetes edge nodes, ARM64 development, learning platform
- Proves that Raspberry Pi 4 is a capable ARM64 platform for light-to-medium server workloads

**Raspberry Pi 5 Model B - Broadcom BCM2712 (Cortex-A76)**
- Board: Raspberry Pi 5 Model B Rev 1.0 (2023)
- Quad-core ARM64 Cortex-A76 processor (2.4 GHz) - flagship Raspberry Pi
- Excellent performance: 62% of i5-13600 single-thread, 22% multi-thread
- Memory performance: 8.2 GB/s write, 15.2 GB/s read - good balance (1.9x R/W ratio)
- 8 GB LPDDR4X RAM provides ample memory for demanding workloads
- Nearly perfect multi-thread scaling (98%) with homogeneous quad-core design
- **Major improvements over RPi 4**: 76% faster single-thread, 90% faster multi-thread, 32% faster write, 117% faster read
- Outperforms Orange Pi 5 (RK3588S) in single-thread despite RK3588S having 8 cores
- Successfully ran sysbench via Podman container runtime
- Best choice for: Home servers, NAS, Kubernetes nodes, ARM64 development, AI/ML edge computing, desktop replacement, demanding containerized workloads
- **Verdict**: RPi 5 is the fastest and most capable Raspberry Pi, delivering performance competitive with budget x86 systems
- Proves that ARM single-board computers can handle medium-to-heavy server workloads

**Raspberry Pi 3 Model B - Broadcom BCM2837 (Cortex-A53)**
- Board: Raspberry Pi 3 Model B Rev 1.2 (2016)
- Quad-core ARM64 Cortex-A53 processor (1.2 GHz)
- Budget ARM64 performance: 14% of i5-13600 single-thread, 4% multi-thread
- Memory performance: 3.3 GB/s write, 3.9 GB/s read - excellent balance (1.2x R/W ratio, second best)
- 1 GB LPDDR2 RAM limits multitasking but adequate for basic tasks
- Good multi-thread scaling (86%) with homogeneous quad-core design
- Performance similar to 10-year-old x86 Celeron despite older ARM cores and LPDDR2 memory
- 2.5x faster than RISC-V U74 in single-thread, shows maturity of ARM ecosystem
- Successfully ran sysbench via Podman
- Best choice for: Budget home server, learning ARM64, lightweight applications, retro gaming, educational projects
- Demonstrates that older Raspberry Pi models remain viable for basic containerized workloads

**Raspberry Pi Zero W - Broadcom BCM2835 (ARMv6)**
- Board: Raspberry Pi Zero W (2015) with BCM2835 SoC
- Ultra-low-power single-core ARMv6 processor (1 GHz)
- Slowest system tested: 564x slower than i5-13600, 55x slower than Celeron 1007U
- Memory performance: 42-2,000x slower than modern systems
- Only 512 MB RAM (430 MB usable, shared with GPU)
- Despite extreme limitations, successfully runs modern Docker containers with sysbench
- Good memory balance (1.3x R/W ratio) due to simple architecture with no caching
- Best choice for: IoT sensors, learning projects, legacy ARMv6 software testing, ultra-low-power edge computing
- Important validation: Proves Docker multi-architecture support works even on slowest ARM platform

**HP t640 Thin Client - AMD Ryzen Embedded R1505G (Zen+)**
- Platform: HP t640 Thin Client (2019) with AMD Zen+ architecture
- Dual-core x86_64 processor @ 2.4 GHz with SMT (4 threads)
- Mid-range performance: 12% of i5-13600 single-thread, 4% multi-thread
- Memory performance: 4.1 GB/s write, 7.0 GB/s read - balanced (1.7x R/W ratio)
- 6 GB DDR4-2400 dual-channel RAM in asymmetric configuration (4GB+2GB)
- Good multi-thread scaling (89%) with SMT technology
- **Unique achievement**: ZERO performance loss in 32-bit mode - only tested CPU with perfect 32-bit/64-bit parity
- Perfect for legacy 32-bit applications requiring full performance
- Successfully ran sysbench via Docker with sudo authentication
- Best choice for: Thin clients, VDI workstations, budget desktops, home offices, legacy x86 software compatibility
- AMD's excellent x86 compatibility makes it ideal for mixed 32-bit/64-bit environments
- Comparable performance to Raspberry Pi 4 but with complete x86 ecosystem support

**Synology DS220+ NAS - Intel Celeron J4025 (Gemini Lake Refresh)**
- Platform: Synology DS220+ 2-bay NAS (2019) running DSM 6.2.x
- Dual-core x86_64 processor @ 2.0 GHz (Gemini Lake Refresh, 14nm)
- Good performance for NAS: 39% of i5-13600 single-thread, 7% multi-thread
- Memory performance: 6.8 GB/s write, 12.3 GB/s read - balanced (1.8x R/W ratio)
- 10 GB DDR4-2666 dual-channel RAM (4GB base + 6GB expansion)
- Excellent multi-thread scaling (96%) with homogeneous dual-core design
- **3.3x faster single-thread than AMD R1505G despite lower clock speed** (2.0 GHz vs 2.4 GHz)
- 1.6x faster memory write and 1.8x faster memory read than HP t640
- 32-bit performance loss: -63% CPU, -62% memory read (avoid 32-bit mode)
- Successfully ran sysbench via Docker with sudo (Synology DSM 6.2.x)
- **NAS strengths**: Excellent software ecosystem (DSM), Docker support, package manager, VM hosting
- Best choice for: Home NAS, file server, media server (Plex/Jellyfin), Docker host, lightweight virtualization
- Ideal balance of performance, power efficiency, and NAS-specific features for home/SMB use

**QNAP TS-251+ NAS - Intel Celeron J1800 (Bay Trail)**
- Platform: QNAP TS-251+ 2-bay NAS (2013) running QTS with Container Station
- Dual-core x86_64 processor @ 2.41 GHz (Bay Trail, outdated 22nm process)
- **Critically low performance**: 9% of i5-13600 single-thread, 1% multi-thread
- **SLOWEST x86 CPU tested** - even older Celeron 1007U (2013) is 5% faster single-thread
- Memory performance: 1.9 GB/s write, 3.1 GB/s read - balanced but extremely slow (1.6x R/W ratio)
- 16 GB DDR3L memory (large capacity doesn't compensate for slow bandwidth)
- **WORST multi-thread scaling**: Only 1.1x speedup on 2 cores (53% efficiency)
- **Critical architectural bottleneck**: Bay Trail cannot effectively utilize both cores
- Slower than Raspberry Pi 3 (2016) despite being x86: RPi 3 is 1.7x faster write, 1.2x faster read
- Only 1.1x faster write than RISC-V VisionFive 2 (the slowest modern platform)
- Successfully ran sysbench via Container Station (`/share/CACHEDEV1_DATA/.qpkg/container-station/bin/docker`)
- Best choice for: Budget file storage, legacy NAS upgrade path, light media serving
- **Strong recommendation**: Upgrade to newer hardware - RPi 4 or DS220+ offer significantly better performance
- **NAS note**: QNAP QTS has good software features, but 11-year-old Bay Trail hardware is severely outdated
- Consider replacing with modern NAS or repurposing as cold storage only

### Docker Image Validation

The `pingwinator/sysbench:latest` Docker image successfully executed on all fifteen test systems across five architectures:
- ✅ linux/amd64 (Intel x86_64) - 64-bit and 32-bit modes (8 systems tested: i5-13600, Pentium N6005, i3-8100T, Celeron 1007U, Celeron J4025, Celeron J1800, AMD R1505G, AMD G-T56N)
- ✅ linux/arm64 (ARM aarch64) - 64-bit and 32-bit modes (5 systems: Orange Pi 5, RPi 5, RPi 4, RPi 3, Apple M1 Mac mini)
- ✅ linux/arm/v7 (ARMv7) - 32-bit mode tested on ARM64 hardware (Orange Pi 5, RPi 5)
- ✅ linux/arm/v6 (ARMv6) - Raspberry Pi Zero W
- ✅ linux/riscv64 (RISC-V 64-bit) - VisionFive 2
- ✅ linux/386 (i386) - 32-bit Intel/AMD tested on all x86_64 systems

**macOS Container Support:**
- ✅ Apple Container framework (macOS 15.0.1) - Native ARM64 and x86_64 via Rosetta 2
- ✅ Docker Desktop for Mac - Native ARM64 and x86_64 via Rosetta 2
- Both platforms successfully run `pingwinator/sysbench:latest` with different performance characteristics

Multi-architecture support is fully validated and production-ready across six architectures spanning 15 different hardware platforms, including macOS with both Apple Container and Docker Desktop.

### Recommendations

**For Maximum Single-Thread Performance:**
- **Apple M1 Mac mini** - NEW CHAMPION with 4,046 evt/s (2.46x faster than i5-13600!)
- Best choice for: Development, content creation, ARM64 builds, Xcode
- Outstanding efficiency with laptop-class power consumption
- Unified Memory ideal for CPU/GPU workloads
- Rosetta 2 provides excellent x86_64 compatibility (only 27% loss)

**For Maximum Multi-Thread Performance:**
- Choose Intel i5-13600 or similar 13th Gen Intel processors
- Use DDR5 memory for best read performance
- Allocate maximum threads for parallel workloads
- Note: Apple M1 nearly matches with only 8 cores vs 20!

**For Best Efficiency:**
- Choose processors with homogeneous cores (Pentium, RISC-V)
- These show 99% multi-thread scaling efficiency
- Good for containerized workloads with predictable performance

**For ARM Workloads:**
- **Apple M1**: Dominates in single-thread, competitive in multi-thread, excellent for macOS developers
- Rockchip RK3588S (Orange Pi 5) provides excellent price/performance with 8 cores
- Raspberry Pi 5 delivers best budget single-board computer performance
- All competitive with Intel in many scenarios
- Lower power consumption than x86_64

**For macOS Development:**
- **Apple M1 with Apple Container**: Best memory performance (28.9 GB/s read), most stable single-thread
- **Apple M1 with Docker Desktop**: 20% faster multi-thread CPU, better compatibility
- Choose Container for memory-intensive workloads, Docker Desktop for CPU-intensive tasks

**For Raspberry Pi Users:**
- Raspberry Pi 5: Best choice for demanding workloads, home servers, and desktop replacement
- Raspberry Pi 4: Still excellent for light-to-medium workloads at lower cost
- Raspberry Pi 3/Zero: Budget options for basic tasks and learning

**For RISC-V Experimentation:**
- SiFive U74 works correctly but is significantly slower
- Perfect for development and testing RISC-V software
- Memory subsystem needs improvement in future hardware revisions

**For ARMv6 and IoT Devices:**
- Raspberry Pi Zero W validates ultra-low-power ARM support
- Extremely slow but functional for sensor nodes and learning projects
- Requires Docker flag `--security-opt seccomp=unconfined` to run sysbench
- Best for legacy ARMv6 software compatibility testing

**For NAS and Home Server Users:**
- **Best performance NAS**: Synology DS220+ (Celeron J4025) - excellent balance of performance, power efficiency, and software features
  - 642 evt/s single-thread, 96% scaling efficiency
  - Superior DSM software ecosystem with Docker, packages, and VM support
  - 3.3x faster than AMD R1505G thin client despite lower clock speed
- **Budget/Legacy NAS**: QNAP TS-251+ (Celeron J1800) - usable for file storage but severely outdated
  - SLOWEST x86 CPU tested with worst scaling (53% efficiency)
  - Consider upgrade to Synology DS220+ (4.2x faster) or even Raspberry Pi 4 (3.5x faster)
  - Bay Trail architecture (2013) has critical bottlenecks preventing effective dual-core usage
- **DIY NAS alternative**: Raspberry Pi 4/5 offer better performance than old NAS hardware at lower cost
  - RPi 5: 6.6x faster CPU than QNAP TS-251+, competitive with Synology DS220+
  - RPi 4: Still 3.5x faster than QNAP TS-251+, excellent for OpenMediaVault or similar

**For Thin Client and Legacy Hardware:**
- **AMD R1505G (HP t640)**: Perfect 32-bit compatibility, good for VDI and legacy software
  - ZERO performance loss in 32-bit mode (unique among all tested systems)
  - Ideal for mixed 32-bit/64-bit environments
- **Avoid**: Intel Celeron 1007U and older - 10+ year old hardware too slow for modern workloads
  - 6-10x slower than modern budget processors
  - Consider replacing with Pentium N6005 thin client or Raspberry Pi 5

---

## Test Methodology

All benchmarks were conducted using Docker containers to ensure consistency across platforms. Tests were run on real hardware (not emulated) with Ubuntu 24.04.3 LTS.

**Test Date:** October 2025

**Sysbench Version:**
- 1.0.20 (amd64, arm64, armv6, riscv64 on Debian sid)
- 1.0.18 (amd64 on older system)

**Docker Image:** `pingwinator/sysbench:latest`

**Test Duration:** 10 seconds per test (default sysbench setting)

---

## Reproducibility

To reproduce these results on your own systems:

```bash
# Determine the optimal number of threads for your system
THREADS=$(nproc)
echo "Your system has $THREADS CPUs"

# Single-threaded CPU test
docker run --rm pingwinator/sysbench:latest

# Multi-threaded CPU test (using all available CPUs)
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  cpu --threads=$THREADS --cpu-max-prime=20000 run

# Or with a fixed thread count (adjust based on your CPU)
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  cpu --threads=4 --cpu-max-prime=20000 run

# Memory write test
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  memory --threads=$THREADS --memory-total-size=50G run

# Memory read test
docker run --rm --entrypoint /usr/bin/sysbench pingwinator/sysbench:latest \
  memory --threads=$THREADS --memory-total-size=50G --memory-oper=read run

# ARMv6 systems (Raspberry Pi Zero/1) require seccomp workaround:
docker run --rm --security-opt seccomp=unconfined pingwinator/sysbench:latest

# ARMv6 memory test (use smaller size due to limited RAM)
docker run --rm --security-opt seccomp=unconfined --entrypoint /usr/bin/sysbench \
  pingwinator/sysbench:latest memory --threads=1 --memory-total-size=1G run
```

---

## 32-bit Architecture Testing

To validate multi-architecture support and measure performance impact, we tested 32-bit container images on 64-bit host systems.

### Test Methodology

- **32-bit validation**: Confirmed with `getconf LONG_BIT` returning 32
- **Library verification**: Checked linked libraries (i386-linux-gnu for x86, armhf for ARM)
- **Platforms tested**:
  - `linux/386` (32-bit x86) on Intel/AMD 64-bit systems
  - `linux/arm/v7` (32-bit ARM) on ARM64 system

### CPU Performance: 64-bit vs 32-bit Comparison

| System | Processor | Mode | Single-Thread | Multi-Thread | MT Speedup | Performance Loss |
|--------|-----------|------|---------------|--------------|------------|-----------------|
| System 1 | i5-13600 | **64-bit** | **1,641.95** | **18,113.55** | 11.0x | - |
| System 1 | i5-13600 | **32-bit** | 409.28 | 5,723.67 | 14.0x | **-75% / -68%** |
| System 2 | RK3588S | **64-bit** | **979.66** | **5,273.76** | 5.4x | - |
| System 2 | RK3588S | **32-bit** | 58.92 | 362.49 | 6.2x | **-94% / -93%** |
| System 3 | Pentium N6005 | **64-bit** | **775.24** | **3,077.02** | 4.0x | - |
| System 3 | Pentium N6005 | **32-bit** | 268.34 | 1,064.23 | 4.0x | **-65% / -65%** |
| System 6 | i3-8100T | **64-bit** | **398.65** | **1,590.39** | 4.0x | - |
| System 6 | i3-8100T | **32-bit** | 227.06 | 908.70 | 4.0x | **-43% / -43%** |
| System 5 | Celeron 1007U | **64-bit** | **161.32** | **290.40** | 1.8x | - |
| System 5 | Celeron 1007U | **32-bit** | 108.98 | 193.44 | 1.8x | **-32% / -33%** |
| System 10 | RPi 5 (A76) | **64-bit** | **1,013.19** | **3,957.99** | 3.9x | - |
| System 10 | RPi 5 (A76) | **32-bit** | 63.32 | 246.96 | 3.9x | **-94% / -94%** |
| System 11 | Ryzen R1505G | **64-bit** | **192.97** | **685.37** | 3.6x | - |
| System 11 | Ryzen R1505G | **32-bit** | 192.94 | 685.69 | 3.6x | **0% / 0%** |
| System 12 | Celeron J4025 | **64-bit** | **642.11** | **1,230.64** | 1.9x | - |
| System 12 | Celeron J4025 | **32-bit** | 238.93 | 461.86 | 1.9x | **-63% / -62%** |

### Memory Performance: 64-bit vs 32-bit Comparison

| System | Processor | Mode | Write (MiB/s) | Read (MiB/s) | R/W Ratio | Performance Loss |
|--------|-----------|------|---------------|--------------|-----------|-----------------|
| System 1 | i5-13600 | **64-bit** | **18,617** | **104,141** | 5.6x | - |
| System 1 | i5-13600 | **32-bit** | 16,001 | 41,990 | 2.6x | **-14% / -60%** |
| System 2 | RK3588S | **64-bit** | **11,463** | **19,457** | 1.7x | - |
| System 2 | RK3588S | **32-bit** | 3,532 | 4,006 | 1.1x | **-69% / -79%** |
| System 3 | Pentium N6005 | **64-bit** | **11,611** | **25,173** | 2.2x | - |
| System 3 | Pentium N6005 | **32-bit** | 7,524 | 9,661 | 1.3x | **-35% / -62%** |
| System 6 | i3-8100T | **64-bit** | **7,824** | **25,138** | 3.2x | - |
| System 6 | i3-8100T | **32-bit** | 6,697 | 10,436 | 1.6x | **-14% / -58%** |
| System 5 | Celeron 1007U | **64-bit** | **3,145** | **5,148** | 1.6x | - |
| System 5 | Celeron 1007U | **32-bit** | 1,768 | 2,152 | 1.2x | **-44% / -58%** |
| System 10 | RPi 5 (A76) | **64-bit** | **8,351** | **15,609** | 1.9x | - |
| System 10 | RPi 5 (A76) | **32-bit** | 1,535 | 1,653 | 1.1x | **-82% / -89%** |
| System 11 | Ryzen R1505G | **64-bit** | **4,249** | **7,140** | 1.7x | - |
| System 11 | Ryzen R1505G | **32-bit** | 4,313 | 7,168 | 1.7x | **+1% / 0%** |
| System 12 | Celeron J4025 | **64-bit** | **5,939** | **9,188** | 1.5x | - |
| System 12 | Celeron J4025 | **32-bit** | 2,950 | 3,821 | 1.3x | **-50% / -58%** |

### Performance Impact Analysis

**CPU Performance Loss (64-bit → 32-bit):**
```
RK3588S (ARM)  ████████████████████▌ -94% single / -93% multi 🔥
RPi 5 (ARM)    ████████████████████▌ -94% single / -94% multi 🔥
i5-13600       ████████████████████ -75% single / -68% multi
Pentium N6005  ████████████████▌    -65% single / -65% multi
Celeron J4025  ████████████████▌    -63% single / -62% multi
i3-8100T       ███████████          -43% single / -43% multi
Celeron 1007U  ████████             -32% single / -33% multi
Ryzen R1505G   ░                    0% single / 0% multi ⭐
```

**Memory Read Performance Loss (64-bit → 32-bit):**
```
RPi 5 (ARM)    ███████████████████████████ -89% read 🔥🔥
RK3588S (ARM)  ████████████████████████▌ -79% read 🔥
Pentium N6005  ████████████████████▌    -62% read
i5-13600       ████████████████████████ -60% read
Celeron J4025  ███████████████████      -58% read
i3-8100T       ███████████████████      -58% read
Celeron 1007U  ███████████████████      -58% read
Ryzen R1505G   ░                        0% read ⭐
```

### Key Findings

**1. ARM 32-bit is Catastrophically Slow**
- **Raspberry Pi 5 (Cortex-A76)**: 94% CPU performance loss, 89% memory read loss - WORST!
  - Single-thread: 63.32 evt/s (32-bit) vs 1,013.19 evt/s (64-bit) = **16.0x slower**
  - Multi-thread: 246.96 evt/s (32-bit) vs 3,957.99 evt/s (64-bit) = **16.0x slower**
- **Orange Pi 5 (RK3588S)**: 94% CPU performance loss, 79% memory read loss
  - Single-thread: 58.92 evt/s (32-bit) vs 979.66 evt/s (64-bit) = **16.6x slower**
  - Multi-thread: 362.49 evt/s (32-bit) vs 5,273.76 evt/s (64-bit) = **14.5x slower**
- **Conclusion**: ARMv7 is essentially unusable on modern ARM64 SoCs - both RPi 5 and Orange Pi 5 lose 94% performance

**2. Modern x86 CPUs Lose More in 32-bit Mode**
- **i5-13600** (2023): 75% single-thread loss, 68% multi-thread loss
- **Pentium N6005** (2021): 65% single-thread loss, 65% multi-thread loss
- **i3-8100T** (2018): 43% single-thread loss, 43% multi-thread loss
- **Celeron 1007U** (2012): 32% single-thread loss, 33% multi-thread loss (best!)

**Why newer CPUs lose more?**
- Modern extensions (AVX2, AVX-VNNI) unavailable in 32-bit mode
- Fewer general-purpose registers (8 vs 16)
- Less optimized compiler paths for 32-bit
- Hybrid architectures (P+E cores) optimized for 64-bit workloads
- Interesting trend: 8th Gen Coffee Lake (i3-8100T) sits between budget Jasper Lake (N6005) and legacy Ivy Bridge (1007U)

**3. AMD Ryzen Shows ZERO Performance Loss in 32-bit Mode!**
- **AMD Ryzen R1505G** (Zen+, 2019): **0% CPU loss, 0% memory loss** - UNIQUE!
  - Single-thread: 192.94 evt/s (32-bit) vs 192.97 evt/s (64-bit) = **identical**
  - Multi-thread: 685.69 evt/s (32-bit) vs 685.37 evt/s (64-bit) = **identical**
  - Memory write: 4,313 MiB/s (32-bit) vs 4,249 MiB/s (64-bit) = **+1.5% faster!**
  - Memory read: 7,168 MiB/s (32-bit) vs 7,140 MiB/s (64-bit) = **identical**
- **Explanation**: Zen architecture's mature x86/x86-64 implementation handles both modes equally well
- **Verdict**: AMD Ryzen Embedded is the ONLY tested processor with zero 32-bit penalty!

**4. Legacy CPUs Handle 32-bit Better**
- **Celeron 1007U** (Ivy Bridge, 2012) shows second-smallest performance loss (32%)
- Designed when 32-bit was still mainstream
- Simple architecture without 64-bit-specific optimizations
- **Verdict**: Old hardware is better suited for 32-bit workloads than modern Intel

**5. Memory Performance Degrades Significantly (except AMD)**
- **Read performance hit**: 58-89% across all platforms except AMD Ryzen (0%)
- **Write performance**: Better than read, 14-82% loss except AMD Ryzen (+1.5%)
- **RPi 5**: Worst memory performance loss - 82% write, 89% read
- i5-13600: Read/Write ratio drops from 5.6x to 2.6x in 32-bit mode
- **Conclusion**: 32-bit addressing limits memory subsystem optimization, except on AMD Zen

**6. Multi-threading Scales Differently**
- **i5-13600**: Better scaling in 32-bit (14.0x vs 11.0x)
- **RK3588S**: Better scaling in 32-bit (6.2x vs 5.4x)
- Simpler instruction set creates more uniform workload distribution

### Practical Recommendations

**❌ Avoid 32-bit on:**
- **Modern ARM64 systems** (94% CPU loss, 89% memory loss is catastrophic)
  - Raspberry Pi 5 and Orange Pi 5 both lose 94% performance
- High-performance Intel x86_64 systems (i5-13600: 75% loss)
- Any system with modern CPU extensions (AVX2, AVX-512)

**✅ Perfect for 32-bit:**
- **AMD Ryzen Embedded** (R1505G: **ZERO** performance loss!) ⭐⭐⭐
  - The ONLY tested processor with identical 32-bit and 64-bit performance
  - Ideal for running legacy 32-bit applications at full speed

**✅ Acceptable for 32-bit:**
- Legacy Intel x86 hardware (Celeron 1007U: 32% loss)
- Budget x86 systems (Pentium N6005: 65% loss tolerable for legacy apps)
- Systems that MUST run old 32-bit-only software

**⚠️ Performance Expectations:**
- **Best case** (AMD Ryzen): **0% performance loss** - perfect 32-bit compatibility!
- **Good case** (old Intel x86): 30-35% performance loss
- **Typical case** (modern Intel x86): 65-75% performance loss
- **Worst case** (modern ARM64): 94% performance loss - essentially unusable

### Test Commands

Reproduce these results:

```bash
# Single-threaded 32-bit CPU test
docker run --rm --platform linux/386 pingwinator/sysbench:latest

# Multi-threaded 32-bit CPU test
docker run --rm --platform linux/386 --entrypoint /usr/bin/sysbench \
  pingwinator/sysbench:latest cpu --threads=4 --cpu-max-prime=20000 run

# 32-bit memory write test
docker run --rm --platform linux/386 --entrypoint /usr/bin/sysbench \
  pingwinator/sysbench:latest memory --threads=4 --memory-total-size=20G run

# 32-bit memory read test
docker run --rm --platform linux/386 --entrypoint /usr/bin/sysbench \
  pingwinator/sysbench:latest memory --threads=4 --memory-total-size=20G --memory-oper=read run

# Verify 32-bit mode
docker run --rm --platform linux/386 --entrypoint /bin/bash \
  pingwinator/sysbench:latest -c 'getconf LONG_BIT'
```

---

**License:** GPL-2.0 (matching sysbench licensing)

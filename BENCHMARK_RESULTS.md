# Sysbench Multi-Architecture Benchmark Results

This document contains comprehensive benchmark results for the `pingwinator/sysbench:latest` Docker image tested across nine different systems spanning five architectures: x86_64 (Intel 13th Gen, 8th Gen, Pentium N6005, Celeron 1007U), ARM64 (Rockchip RK3588S, Raspberry Pi 4, Raspberry Pi 3), ARMv6 (Raspberry Pi Zero W), and RISC-V 64-bit (SiFive).

## Test Environment

All tests were conducted on real hardware running Ubuntu 22.04/24.04 LTS (x86_64, ARM64, RISC-V) and Raspbian 10 Buster (ARMv6) using Docker containers. The sysbench Docker image successfully ran on all five architectures without any compatibility issues.

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
| System 1 | Intel Core i5-13600 | **1,641.95** | 0.61 ms | 100% (Fastest) |
| System 2 | Rockchip RK3588S | 979.66 | 1.02 ms | 60% |
| System 3 | Intel Pentium N6005 | 775.24 | 1.29 ms | 47% |
| System 8 | Cortex-A72 (RPi 4) | 575.31 | 1.74 ms | 35% |
| System 6 | Intel Core i3-8100T | 398.65 | 2.51 ms | 24% |
| System 9 | Cortex-A53 (RPi 3) | 234.15 | 4.26 ms | 14% |
| System 4 | SiFive U74-MC | 198.82 | 5.03 ms | 12% |
| System 5 | Intel Celeron 1007U | 161.32 | 6.19 ms | 10% |
| System 7 | BCM2835 (RPi Zero W) | 2.91 | 342.13 ms | 0.18% |

**Performance Chart:**
```
i5-13600       ████████████████████ 1,642 evt/s (100%)
RK3588S        ████████████         980 evt/s   (60%)
Pentium N6005  █████████            775 evt/s   (47%)
RPi 4 (A72)    ███████              575 evt/s   (35%)
i3-8100T       █████                399 evt/s   (24%)
RPi 3 (A53)    ███                  234 evt/s   (14%)
RISC-V U74     ██                   199 evt/s   (12%)
Celeron 1007U  ██                   161 evt/s   (10%)
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
| System 1 | Intel Core i5-13600 | 20 | 1,641.95 | **18,113.55** | 11.0x | 55% |
| System 2 | Rockchip RK3588S | 8 | 979.66 | **5,273.76** | 5.4x | 67% |
| System 3 | Intel Pentium N6005 | 4 | 775.24 | **3,077.02** | 4.0x | 99% |
| System 8 | Cortex-A72 (RPi 4) | 4 | 575.31 | **2,078.67** | 3.6x | 90% |
| System 6 | Intel Core i3-8100T | 4 | 398.65 | **1,590.39** | 4.0x | 99% |
| System 9 | Cortex-A53 (RPi 3) | 4 | 234.15 | **808.37** | 3.5x | 86% |
| System 4 | SiFive U74-MC | 4 | 198.82 | **789.96** | 4.0x | 99% |
| System 5 | Intel Celeron 1007U | 2 | 161.32 | **290.40** | 1.8x | 90% |

**Absolute Performance Chart:**
```
i5-13600       ████████████████████ 18,113 evt/s (100%)
RK3588S        ██████               5,274 evt/s  (29%)
Pentium N6005  ████                 3,077 evt/s  (17%)
RPi 4 (A72)    ███                  2,079 evt/s  (11%)
i3-8100T       ██                   1,590 evt/s  (9%)
RPi 3 (A53)    █                    808 evt/s    (4%)
RISC-V U74     █                    790 evt/s    (4%)
Celeron 1007U  █                    290 evt/s    (2%)
```

**Scaling Efficiency Analysis:**

**Efficiency = (Speedup / Thread Count) × 100%**

#### Perfect Scaling (99%):
- **Intel Pentium N6005**: 4.0x speedup on 4 threads = 99% efficiency
- **Intel Core i3-8100T**: 4.0x speedup on 4 threads = 99% efficiency
- **SiFive U74 (RISC-V)**: 4.0x speedup on 4 threads = 99% efficiency

These processors show nearly linear scaling! Each core works at full capacity without losses.

#### Excellent Scaling (86-90%):
- **Cortex-A72 (Raspberry Pi 4)**: 3.6x speedup on 4 threads = 90% efficiency
- **Intel Celeron 1007U**: 1.8x speedup on 2 threads = 90% efficiency
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
| **System 2** | Rockchip RK3588S | 16 GB | LPDDR4X/5 | **11,463** | **19,457** | 1.7x |
| **System 8** | Cortex-A72 (RPi 4) | 4 GB | LPDDR4 | **6,313** | **7,177** | 1.1x |
| **System 9** | Cortex-A53 (RPi 3) | 1 GB | LPDDR2 | **3,354** | **4,026** | 1.2x |
| **System 5** | Intel Celeron 1007U | 8 GB | DDR3 (?) | **3,145** | **5,148** | 1.6x |
| **System 4** | SiFive U74-MC | 8 GB | DDR4 (?) | **1,761** | **2,385** | 1.4x |
| **System 7** | BCM2835 (RPi Zero W) | 512 MB | LPDDR2 (shared) | **41.56** | **52.34** | 1.3x |

**Write Performance Chart:**
```
i5-13600       ████████████████████ 18,617 MiB/s (100%)
Pentium N6005  ████████████▌        11,611 MiB/s (62%)
RK3588S        ████████████▍        11,463 MiB/s (62%)
RPi 4 (A72)    ███████               6,313 MiB/s (34%)
RPi 3 (A53)    ████                  3,354 MiB/s (18%)
Celeron 1007U  ████                  3,145 MiB/s (17%)
RISC-V U74     █                     1,761 MiB/s (9%)
RPi Zero W     ░                        41 MiB/s (0.2%)
```

**Read Performance Chart:**
```
i5-13600       ████████████████████ 104,141 MiB/s (100%)
Pentium N6005  █████                 25,173 MiB/s (24%)
RK3588S        ████                  19,457 MiB/s (19%)
RPi 4 (A72)    ██                     7,177 MiB/s (7%)
Celeron 1007U  █                      5,148 MiB/s (5%)
RPi 3 (A53)    █                      4,026 MiB/s (4%)
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

### Memory Type Comparison

| Memory Type | Processor | Platform | Write | Read | Overall Rating |
|------------|-----------|----------|-------|------|----------------|
| DDR5-4800 | i5-13600 | Desktop PC | 18.2 GB/s | 101.7 GB/s | ⭐⭐⭐⭐⭐ |
| DDR4-2933 | Pentium N6005 | Dell Wyse 3000 | 11.3 GB/s | 24.6 GB/s | ⭐⭐⭐⭐ |
| LPDDR4X | RK3588S | Orange Pi 5 | 11.2 GB/s | 19.0 GB/s | ⭐⭐⭐ |
| DDR4 | i3-8100T | ThinkCentre M720q | 7.6 GB/s | 24.5 GB/s | ⭐⭐⭐⭐ |
| LPDDR4 | Cortex-A72 | Raspberry Pi 4 | 6.2 GB/s | 7.0 GB/s | ⭐⭐⭐ |
| LPDDR2 | Cortex-A53 | Raspberry Pi 3 | 3.3 GB/s | 3.9 GB/s | ⭐⭐ |
| DDR3 | Celeron 1007U | ASUS VM40B | 3.1 GB/s | 5.0 GB/s | ⭐⭐ |
| LPDDR4 | SiFive U74 | VisionFive 2 | 1.7 GB/s | 2.3 GB/s | ⭐ |
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
3. Rockchip RK3588S (LPDDR): 11.2 GB/s
4. Intel Core i3-8100T (DDR4): 7.6 GB/s
5. Cortex-A72/RPi 4 (LPDDR4): 6.2 GB/s
6. Cortex-A53/RPi 3 (LPDDR2): 3.3 GB/s
7. Intel Celeron 1007U (DDR3): 3.1 GB/s
8. SiFive U74 (LPDDR4): 1.7 GB/s
9. BCM2835 (LPDDR2): 0.04 GB/s

**By Read Speed:**
1. Intel i5-13600 (DDR5): 101.7 GB/s
2. Intel Pentium N6005 (DDR4): 24.6 GB/s
3. Intel Core i3-8100T (DDR4): 24.5 GB/s
4. Rockchip RK3588S (LPDDR): 19.0 GB/s
5. Cortex-A72/RPi 4 (LPDDR4): 7.0 GB/s
6. Intel Celeron 1007U (DDR3): 5.0 GB/s
7. Cortex-A53/RPi 3 (LPDDR2): 3.9 GB/s
8. SiFive U74 (LPDDR4): 2.3 GB/s
9. BCM2835 (LPDDR2): 0.05 GB/s

**By Balance (R/W ratio closer to 1 = better):**
1. Cortex-A72/RPi 4: 1.1x (best balanced memory subsystem)
2. Cortex-A53/RPi 3: 1.2x (excellent balance for LPDDR2)
3. BCM2835 (RPi Zero W): 1.3x (extremely simple, minimal caching)
4. SiFive U74: 1.4x (simple but balanced)
5. Intel Celeron 1007U: 1.6x (old but balanced)
6. Rockchip RK3588S: 1.7x
7. Intel Pentium N6005: 2.2x
8. Intel Core i3-8100T: 3.2x
9. Intel i5-13600: 5.6x (optimized for read)

---

## Overall Conclusions

### Platform-Specific Insights

**Intel Core i5-13600 (13th Gen, Raptor Lake)**
- Absolute performance champion in all categories
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

### Docker Image Validation

The `pingwinator/sysbench:latest` Docker image successfully executed on all architectures:
- ✅ linux/amd64 (Intel x86_64) - 64-bit and 32-bit modes
- ✅ linux/arm64 (ARM aarch64) - 64-bit and 32-bit modes
- ✅ linux/arm/v6 (ARMv6) - Raspberry Pi Zero W
- ✅ linux/riscv64 (RISC-V 64-bit)

Multi-architecture support is fully validated and production-ready across five architectures.

### Recommendations

**For Maximum Performance:**
- Choose Intel i5-13600 or similar 13th Gen Intel processors
- Use DDR5 memory for best read performance
- Allocate maximum threads for parallel workloads

**For Best Efficiency:**
- Choose processors with homogeneous cores (Pentium, RISC-V)
- These show 99% multi-thread scaling efficiency
- Good for containerized workloads with predictable performance

**For ARM Workloads:**
- Rockchip RK3588S provides excellent price/performance
- Competitive with Intel in many scenarios
- Lower power consumption than x86_64

**For RISC-V Experimentation:**
- SiFive U74 works correctly but is significantly slower
- Perfect for development and testing RISC-V software
- Memory subsystem needs improvement in future hardware revisions

**For ARMv6 and IoT Devices:**
- Raspberry Pi Zero W validates ultra-low-power ARM support
- Extremely slow but functional for sensor nodes and learning projects
- Requires Docker flag `--security-opt seccomp=unconfined` to run sysbench
- Best for legacy ARMv6 software compatibility testing

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

### Performance Impact Analysis

**CPU Performance Loss (64-bit → 32-bit):**
```
RK3588S (ARM)  ████████████████████▌ -94% single / -93% multi 🔥
i5-13600       ████████████████████ -75% single / -68% multi
Pentium N6005  ████████████████▌    -65% single / -65% multi
i3-8100T       ███████████          -43% single / -43% multi
Celeron 1007U  ████████             -32% single / -33% multi
```

**Memory Read Performance Loss (64-bit → 32-bit):**
```
RK3588S (ARM)  ████████████████████████▌ -79% read 🔥
Pentium N6005  ████████████████████▌    -62% read
i5-13600       ████████████████████████ -60% read
i3-8100T       ███████████████████      -58% read
Celeron 1007U  ███████████████████      -58% read
```

### Key Findings

**1. ARM 32-bit is Catastrophically Slow**
- **Orange Pi 5 (RK3588S)**: 94% CPU performance loss, 79% memory read loss
- Single-thread: 58.92 evt/s (32-bit) vs 979.66 evt/s (64-bit) = **16.6x slower**
- Multi-thread: 362.49 evt/s (32-bit) vs 5,273.76 evt/s (64-bit) = **14.5x slower**
- **Conclusion**: ARMv7 is essentially unusable on modern ARM64 SoCs

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

**3. Legacy CPUs Handle 32-bit Better**
- **Celeron 1007U** (Ivy Bridge, 2012) shows smallest performance loss
- Designed when 32-bit was still mainstream
- Simple architecture without 64-bit-specific optimizations
- **Verdict**: Old hardware is better suited for 32-bit workloads

**4. Memory Performance Degrades Significantly**
- **Read performance hit**: 58-79% across all platforms
- **Write performance**: Better than read, 14-69% loss
- i5-13600: Read/Write ratio drops from 5.6x to 2.6x in 32-bit mode
- **Conclusion**: 32-bit addressing limits memory subsystem optimization

**5. Multi-threading Scales Differently**
- **i5-13600**: Better scaling in 32-bit (14.0x vs 11.0x)
- **RK3588S**: Better scaling in 32-bit (6.2x vs 5.4x)
- Simpler instruction set creates more uniform workload distribution

### Practical Recommendations

**❌ Avoid 32-bit on:**
- Modern ARM64 systems (94% performance loss is unacceptable)
- High-performance x86_64 systems (i5-13600: 75% loss)
- Any system with modern CPU extensions (AVX2, AVX-512)

**✅ Acceptable for 32-bit:**
- Legacy x86 hardware (Celeron 1007U: only 32% loss)
- Budget x86 systems (Pentium N6005: 65% loss tolerable for legacy apps)
- Systems that MUST run old 32-bit-only software

**⚠️ Performance Expectations:**
- **Best case** (old x86): 30-35% performance loss
- **Typical case** (modern x86): 65-75% performance loss
- **Worst case** (ARM): 93-94% performance loss

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

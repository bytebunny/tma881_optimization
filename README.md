[//]: # (To preview markdown file in Emacs type C-c C-c p)

# Assignment 1: Optimization
The goal of the first assignment is to practice how to time and profile code,
and to inspect some aspects that contribute to performance.

## Time
Parametric study of **optimization flags**:

- `-O0`: the average elapsed time of 10 loops is 2.195925845 sec (min).
- `-O1`: the average elapsed time of 10 loops is 2.198843204 sec.
- `-O2`: the average elapsed time of 10 loops is 2.199601650 sec (max).
- `-O3`: the average elapsed time of 10 loops is 2.196532865 sec.
- `-Os`: the average elapsed time of 10 loops is 2.196100256 sec.
- `-Og`: the average elapsed time of 10 loops is 2.199355819 sec.

Example of compilation to assembly code for `-O0`:
`gcc time_sum.c -S -O0 -o time_sum_O0.s`

## Inlining
Benchmarking of `mainfile` program:
![mainfile benchmark](./img/benchmark_mainfile.png)

Benchmarking of `separatefile` program:
![separatefile benchmark](./img/benchmark_separatefile.png)

Benchmarking of `inlined` program:
![inlined benchmark](./img/benchmark_inlined.png)

The `separatefile` program is **slower** possibly because the compiler
misses the information about the program, needed to optimize the
code (e.g. automatic inlining).
To remedy this, one might try to enable **link-time optimizer**.

### `nm` tool
When examining the first two executables for symbols that correspond to
`mul_cpx_mainfile` and `mul_cpx_separatefile`, they can be found in
both cases:
```
0000000000401120 T mul_cpx_mainfile
00000000004011a0 T mul_cpx_separatefile
```

## Locality
The time of row and column summations compiled with `-O0, -march=native` flags was:

- Average (from 10,000) elapsed time of **row** summation: 2.407893455 msec.
- Average (from 10,000) elapsed time of **column** summation: 2.905988410 msec.


The original code compiled with 2nd level optimization (`-O2`) gave faster resuts:

- Average (from 10,000) elapsed time of **row** summation: 1.031412517 msec.
- Average (from 10,000) elapsed time of **column** summation: 1.420934522 msec.

If we take into account the memory access pattern, it is possible to
speed up the **column** summation procedure by respecting the fact that cache
line prefetches data in a row:
```
for ( size_t ix=0; ix < nrs; ++ix )
    sums[ix] = 0; // Initialize sum.
    
for ( size_t ix=0; ix < nrs; ++ix )
    for ( size_t jx=0; jx < ncs; ++jx )
        sums[jx] += matrix[ix][jx];
```
If we apply this procedure to both **row** and **column** summations (for the row
summation case additional initialization loop is superfluous because the initialization
can be done inside the outer loop) the timings become as follows:

- Average (from 10,000) elapsed time of **row** summation: 1.074372172 msec.
- Average (from 10,000) elapsed time of **column** summation: 0.560611644 msec.

At the first glance, this is a surprising result.
However, if one takes into account the part of the lecture on **Hardware architecture**
that concerns **pipelining** and **data blocking**,
it is possible to realize that that in the case of the **row** summation the
same element in `sums` array is being accessed within the inner loop, and the
CPU cannot know that the instructions of adding elements within the inner loop
are _independent_:
```
for ( size_t ix=0; ix < nrs; ++ix ){
    sums[ix] = 0; // Initialize sum.

    for ( size_t jx=0; jx < ncs; ++jx )
        sums[jx] += matrix[ix][jx];
}
```
This **breaks the pipeling** and the instructions are carried out sequentually!

The pipelining can be fixed by explicitly telling the CPU that the instructions
are independent.
To this end, one can introduce **additional variables** and partially
**unroll the loop**:
```
for ( size_t ix=0; ix < nrs; ++ix ){
    double sum0 = 0, sum1 = 0, sum2 = 0, sum3 = 0;
    for ( size_t jx=0; jx < ncs; jx += 4 ){
        sum0 += matrix[ix][jx    ];
        sum1 += matrix[ix][jx + 1];
        sum2 += matrix[ix][jx + 2];
        sum3 += matrix[ix][jx + 3];
    }
    sums[ix] = sum0 + sum1 + sum2 + sum3;
}
```
As a result, the **row** summation procedure is faster again:

- Average (from 10,000) elapsed time of row summation: 0.321366179 msec.
- Average (from 10,000) elapsed time of column summation: 0.476664307 msec.

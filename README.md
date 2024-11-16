## Admixture pipeline

Pipeline to run [Admixture software](https://dalexander.github.io/admixture/) from a plink file in ComputeCanada servers.

Optionally, it can produce a plot with CLUMPP+distruct (requires extra installation).


###  Usage:

`sbatch Admixture_pipeline [-a] -p [path to plink base] -K [list or range] -r [int]`

Options:

```
-h     Print usage.
-p     path to plink files (basename).
-K     Int, List or range of Ks to test.
           -K 2,5,7 will test Ks 2,5,7
           -K 2-4 will test Ks 2,3,4
           -K 1-7:2 will test Ks 1,3,5,7
-r     Number of independent runs per K.
-l     Tune the ld pruning option in plink. Default = 0.5
-a     Optional. Plot with clumpp and distruct.
```
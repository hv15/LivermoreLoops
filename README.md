# LivermoreLoops
Sac implementations of the Livermore Loop benchmarks

Building programs require operational sac2c and CMake (at least version 3.3).

Building instructions:
```bash
$ cd LivermoreLoops
$ git submodule init
$ git submodule update
$ mkdir build
$ cd build
$ cmake ..
$ make -j5
```
Compiled files will be available under `build` directory, under corresponding
sub-directories.  Each directory will be build for `seq` and `mt_pth` targets,
appending the name of the target to the name of the directory.

## Benchmarks

- Livermore Loop # 1: (Parallel) hydro fragment
- Livermore Loop # 2: (Sequential) incomplete Cholesky - CG
- Livermore Loop # 3: Inner Product on Vectors
- Livermore Loop # 4: Banded Linear Equations
- Livermore Loop # 5: (Sequential) Tri-Diagonal Elimination - Below Diagonal
- Livermore Loop # 6: General Linear Recurrence Equations
- Livermore Loop # 7: Equation of State Fragment


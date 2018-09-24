# AmberTools 18 Container

### Serial version

To run it:
```
docker run -it --rm \
	   --user=$(id -u) \
	   --volume=/etc/passwd:/etc/passwd:ro \
           --workdir=`pwd` \
           --volume=/home/$USER:/home/$USER \
           --volume=/media:/media \
	   --volume=/mnt:/mnt \
           afandiadib/ambertools:serial bash
```

### Parallel version (openMPI with PnetCDF)

I create a shell script to run it as it requires ptrace_scope to be set to 0 under priviledged mode.

```bash
#!/bin/bash
docker run -it -d --privileged \
           --name AmberTools18 \
           --user=$(id -u) \
	   --volume=/etc/passwd:/etc/passwd:ro \
           --workdir=`pwd` \
           --volume=/home/$USER:/home/$USER \
           --volume=/media:/media \
	   --volume=/mnt:/mnt \
           afandiadib/ambertools:parallel bash
           
docker exec -it \
            --user=0 \
            AmberTools18 sh -c 'echo 0 > /proc/sys/kernel/yama/ptrace_scope'

docker exec -it \
            AmberTools18 bash
```

## Compilation tests result:

1. Serial version
```
make test.serial

2286 file comparisons passed
0 file comparisons failed
0 tests experienced errors
```
2. Parallel version - serial run
```
make test.serial

2101 file comparisons passed
0 file comparisons failed
0 tests experienced errors
```

3. Parallel version - 2 cores
```
export DO_PARALLEL="mpirun -np 2"
make test.parallel

1075 file comparisons passed
0 file comparisons failed
2 tests experienced errors
```

4. Parallel test - 4 cores
```
export DO_PARALLEL="mpirun -np 4"
make test.parallel

1034 file comparisons passed
0 file comparisons failed
1 tests experienced errors
```

# AmberTools 18 Container

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
## Compilation tests result:

```
make test.serial

2101 file comparisons passed
0 file comparisons failed
0 tests experienced errors
```

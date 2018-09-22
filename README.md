# AmberTools 18 Container

To run it:
```
docker run -it --rm \
	   --user=$(id -u) \
	   --volume=/etc/passwd:/etc/passwd:ro \
           --workdir=`pwd` \
           --volume=/home/$USER:/home/$USER \
           --volume=/media:/media --volume=/mnt:/mnt \
           afandiadib/ambertools bash
```
## Compilation tests result:


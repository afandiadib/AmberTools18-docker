FROM afandiadib/ambertools:serial
MAINTAINER "Adib Afandi bin Abdullah <fendy90.oscura@gmail.com>"

ENV PATH="/opt/openmpi-3.1.2/bin:$PATH"
ENV PATH="/opt/PnetCDF/bin:$PATH"
RUN apt-get update && \

# AmberTools 18
    apt-get -y install wget ssh && \
    
    wget https://download.open-mpi.org/release/open-mpi/v3.1/openmpi-3.1.2.tar.bz2 && \
    tar -xf openmpi-3.1.2.tar.bz2 && \
    mkdir /openmpi-3.1.2/build && cd /openmpi-3.1.2/build && \
    ../configure --prefix=/opt/openmpi-3.1.2 && make all install && \
    
    wget http://cucis.ece.northwestern.edu/projects/PnetCDF/Release/parallel-netcdf-1.10.0.tar.gz && \
    tar -xzvf parallel-netcdf-1.10.0.tar.gz && cd parallel-netcdf-1.10.0 && \
    ./configure --prefix=/opt/PnetCDF && make && make install && \

    cd /opt/amber18 && \
    yes | ./configure -mpi --with-pnetcdf /opt/PnetCDF gnu && make install && make clean && \

    chmod -R 777 /opt && \
# cleanup
    rm -rf /openmpi-3.1.2.tar.bz2 /openmpi-3.1.2 /parallel-netcdf-1.10.0.tar.gz /parallel-netcdf-1.10.0 && \
    apt-get -y purge wget && \
    apt-get -y autoremove && apt-get -y clean && rm -rf /var/lib/apt/lists/*

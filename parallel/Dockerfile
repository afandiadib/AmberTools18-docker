FROM afandiadib/ambertools:serial
MAINTAINER "Adib Afandi bin Abdullah <fendy90.oscura@gmail.com>"

ENV AMBERHOME=/opt/amber18
ENV AMBER_PREFIX=/opt/amber18
ENV PATH="${AMBER_PREFIX}/bin:${PATH}"
ENV PYTHONPATH="${AMBER_PREFIX}/lib/python3.6/site-packages"
ENV LD_LIBRARY_PATH="${AMBER_PREFIX}/lib"
ENV PATH="/opt/PnetCDF/bin:$PATH"
RUN apt-get update && \

# AmberTools 18
    apt-get -y install openmpi-bin libopenmpi-dev ssh && \
    wget http://cucis.ece.northwestern.edu/projects/PnetCDF/Release/parallel-netcdf-1.10.0.tar.gz && \
    tar -xzvf parallel-netcdf-1.10.0.tar.gz && cd parallel-netcdf-1.10.0 && \
    ./configure --prefix=/opt/PnetCDF && make && make install && \

    cd /opt/amber18 && \
    ./configure -mpi --with-pnetcdf /opt/PnetCDF gnu && make install && \

    chmod -R 777 /opt && \
# cleanup
    apt-get -y autoremove && apt-get -y clean && rm -rf /var/lib/apt/lists/*

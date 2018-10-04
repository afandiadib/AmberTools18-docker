FROM afandiadib/conda:nvidia
MAINTAINER "Adib Afandi bin Abdullah <fendy90.oscura@gmail.com>"

ENV AMBERHOME=/opt/amber18
ENV AMBER_PREFIX=/opt/amber18
ENV PATH="/opt/PnetCDF/bin:/opt/openmpi-3.1.2/bin:${AMBER_PREFIX}/bin:${PATH}"
ENV LD_LIBRARY_PATH="${AMBER_PREFIX}/lib"

RUN apt-get update && \

# AmberTools 18
    apt-get -y install curl unzip wget ssh && \
    apt-get -y install csh flex patch gfortran g++ make xorg-dev libbz2-dev zlib1g-dev \
                    libboost-dev libboost-thread-dev libboost-system-dev libboost-all-dev && \

    wget https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip && \
    unzip pup_v0.4.0_linux_amd64.zip && chmod +x pup && \
    filename=AmberTools18.tar.bz2 && \
    fileid=1HBURnAo7G6_LqnY_OQba597xSBjt9OHe && \
    query=`curl -c ./cookie.txt -s -L "https://drive.google.com/uc?export=download&id=${fileid}" | ./pup 'a#uc-download-link attr{href}' | sed -e 's/amp;//g'` && \
    curl -s -b ./cookie.txt -L -o ${filename} "https://drive.google.com${query}" && \

    tar -xf AmberTools18.tar.bz2 -C /opt/ && \
    cd /opt/amber18 && yes | ./configure --with-python `which python` gnu && make install && make clean && \

    wget https://download.open-mpi.org/release/open-mpi/v3.1/openmpi-3.1.2.tar.bz2 && \
    tar -xf openmpi-3.1.2.tar.bz2 && \
    mkdir /openmpi-3.1.2/build && cd /openmpi-3.1.2/build && \
    ../configure --prefix=/opt/openmpi-3.1.2 && make all install && \
    
    wget http://cucis.ece.northwestern.edu/projects/PnetCDF/Release/parallel-netcdf-1.10.0.tar.gz && \
    tar -xzvf parallel-netcdf-1.10.0.tar.gz && cd parallel-netcdf-1.10.0 && \
    ./configure --prefix=/opt/PnetCDF && make && make install && \

    cd /opt/amber18 && \
    yes | ./configure --with-python `which python` -mpi --with-pnetcdf /opt/PnetCDF gnu && make install && make clean && \

    chmod -R 777 /opt && \
    
# cleanup
    rm -rf /pup_v0.4.0_linux_amd64.zip /pup /AmberTools18.tar.bz2 /openmpi-3.1.2.tar.bz2 /openmpi-3.1.2 \
           /parallel-netcdf-1.10.0.tar.gz /parallel-netcdf-1.10.0 && \
    apt-get -y purge curl unzip wget && \
    apt-get -y autoremove && apt-get -y clean && rm -rf /var/lib/apt/lists/*

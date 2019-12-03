# Base Image
FROM ubuntu:latest

# Metadata
LABEL base_image="ubuntu:latest"
LABEL software="Cell Ranger"
LABEL software.version="3.0.2"
LABEL about.documentation="https://github.com/10XGenomics/cellranger"
LABEL about.summary="Docker image for the CellRanger software.  This image is not provided\
    or supported by 10X Genomics, and uses the unsupported source code on github"
LABEL about.license="SPDX:MIT"
LABEL about.tags="scRNA"

# install dependencies
RUN apt-get update \
 && apt-get install -y \
    binutils \
    build-essential \
    clang-6.0 \
    curl \
    git \
    golang-1.9 \
    libatlas-base-dev \
    libz-dev \
    libbz2-dev \
    liblzma-dev \
    liblz4-tool \
    libopenblas-dev \
    python-numpy \
    python-pip \
    samtools \
    wget

# install the correct version of python
ENV pyversion 2.7.13
RUN wget https://www.python.org/ftp/python/${pyversion}/Python-${pyversion}.tgz && tar -xvf Python-${pyversion}.tgz
WORKDIR Python-${pyversion}
RUN ./configure
RUN make
ENV PATH $PATH:/Python-${pyversion}

# install python dependencies with pip
RUN pip install cffi Cython==0.28.5 docopts h5py Jinja2 lz4 pandas pyfasta pysam python-config pyvcf scipy sklearn tables

# export path to golang
ENV PATH="/usr/lib/go-1.9/bin:$PATH"

# download and install rustup
RUN curl https://sh.rustup.rs -sSf \
    | sh -s -- -y --profile minimal \
    --default-toolchain nightly

# export cargo path    
ENV PATH="/root/.cargo/bin:$PATH"

# install correct version of rustup
RUN rustup install 1.28.0 && rustup default 1.28.0

# Download precompiled martian and unpack
RUN wget https://github.com/martian-lang/martian/releases/download/v3.2.0/martian-v3.2.0-linux-x86_64.tar.gz \
  && tar -xf martian-v3.2.0-linux-x86_64.tar.gz && rm martian-v3.2.0-linux-x86_64.tar.gz

# Install STAR aligner
RUN wget https://github.com/alexdobin/STAR/archive/2.5.1b.tar.gz \
 && tar -xf 2.5.1b.tar.gz \
 && rm 2.5.1b.tar.gz \
 && cd STAR-2.5.1b \
 && make \
 && cp bin/Linux_x86_64/STAR /usr/bin \
 && cd .. \
 && rm -rf STAR-2.5.1b

# Install tsne
RUN git clone https://github.com/danielfrg/tsne \
 && cd tsne \
 && make install \
 && cd .. \
 && rm -rf tsne

# clone cellranger sourcecode repo, cd into this dir, and install cellranger
RUN git clone https://github.com/10XGenomics/cellranger.git \
  && cd cellranger && make 

# setup environment to run cellranger
ENV PATH /Python-2.7.13/cellranger/bin/:/Python-2.7.13/cellranger/lib/bin:/Python-2.7.13/cellranger/tenkit/bin/:/Python-2.7.13/cellranger/tenkit/lib/bin:/Python-2.7.13/martian-v3.2.0-linux-x86_64/bin:$PATH

ENV PYTHONPATH /Python-2.7.13/cellranger/lib/python:/Python-2.7.13/cellranger/tenkit/lib/python:$PYTHONPATH

ENV MROPATH /Python-2.7.13/cellranger/mro:$MROPATH

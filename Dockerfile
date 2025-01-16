FROM codercom/code-server:latest
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>
RUN sudo apt-get update && sudo apt-get upgrade -y && \
    # install general dependencies
    sudo apt-get install -y --no-install-recommends bison bzip2 cmake flex libboost-all-dev libbz2-dev libcurl4-openssl-dev libeigen3-dev liblzma-dev g++ gcc git make python3 python3-pip zlib1g-dev && \
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib && \

    # install Python packages
    sudo -H pip3 install --break-system-packages phylo-treetime && \

    # install htslib
    wget -qO- "https://github.com/samtools/htslib/releases/download/1.20/htslib-1.20.tar.bz2" | tar -xj && \
    cd htslib-* && \
    ./configure && \
    make && \
    sudo make install && \
    cd .. && \
    rm -rf htslib-* && \

    # install Bowtie2
    wget -qO- "https://github.com/BenLangmead/bowtie2/archive/refs/tags/v2.5.4.tar.gz" | tar -zx && \
    cd bowtie2-* && \
    make && \
    sudo make install && \
    cd .. && \
    rm -rf bowtie2-* && \

    # install BWA
    wget -qO- "https://github.com/lh3/bwa/archive/refs/tags/v0.7.18.tar.gz" | tar -zx && \
    cd bwa-* && \
    make && \
    sudo mv bwa /usr/local/bin/bwa && \
    cd .. && \
    rm -rf bwa-* && \

    # install FastTree
    wget "http://www.microbesonline.org/fasttree/FastTree.c" && \
    gcc -DUSE_DOUBLE -DOPENMP -fopenmp -O3 -finline-functions -funroll-loops -Wall -o FastTree FastTree.c -lm && \
    sudo mv FastTree /usr/local/bin && \
    rm FastTree.c && \

    # install IQ-TREE 2
    wget -qO- "https://github.com/iqtree/iqtree2/releases/download/v2.3.6/iqtree-2.3.6-Linux-intel.tar.gz" | tar -zx && \
    sudo mv iqtree-*/bin/iqtree2 /usr/local/bin/iqtree2 && \
    rm -rf iqtree-* && \

    # install MAFFT
    wget -qO- "https://mafft.cbrc.jp/alignment/software/mafft-7.525-without-extensions-src.tgz" | tar -zx && \
    cd mafft-*/core && \
    make clean && \
    make && \
    sudo make install && \
    cd ../.. && \
    rm -rf mafft-* && \

    # install Minimap2
    wget -qO- "https://github.com/lh3/minimap2/releases/download/v2.28/minimap2-2.28_x64-linux.tar.bz2" | tar -xj && \
    sudo mv minimap2-*/minimap2 /usr/local/bin/minimap2 && \
    rm -rf minimap2-* && \

    # install newick_utils
    wget -qO- "https://github.com/Niema-Docker/newick-utils/raw/refs/heads/main/newick-utils-1.6-Linux-x86_64-disabled-extra.tar.gz" | tar -zx && \
    sudo mv newick-utils-*/src/nw_* /usr/local/bin/ && \
    rm -rf newick-utils-* && \

    # install SPAdes
    wget -qO- "https://github.com/ablab/spades/releases/download/v4.0.0/SPAdes-4.0.0-Linux.tar.gz" | tar -zx && \
    sudo mv SPAdes-*/bin/* /usr/local/bin/ && \
    sudo mv SPAdes-*/share/* /usr/local/share/ && \
    rm -rf SPAdes-* && \

    # install ViralConsensus
    wget -qO- "https://github.com/niemasd/ViralConsensus/archive/refs/tags/0.0.6.tar.gz" | tar -zx && \
    cd ViralConsensus-* && \
    make && \
    sudo mv viral_consensus /usr/local/bin/viral_consensus && \
    cd .. && \
    rm -rf ViralConsensus-* && \

    # install ViralMSA
    sudo wget -O /usr/local/bin/ViralMSA.py "https://github.com/niemasd/ViralMSA/releases/download/1.1.44/ViralMSA.py" && \
    sudo chmod a+x /usr/local/bin/ViralMSA.py && \

    # clean up
    sudo apt-get autoremove -y && \
    sudo apt-get purge -y --auto-remove && \
    sudo rm -rf /var/lib/apt/lists/*
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"

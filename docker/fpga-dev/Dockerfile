FROM condaforge/mambaforge

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update; apt-get install -y \
  binutils-riscv64-unknown-elf \
  build-essential \
  device-tree-compiler \
  gcc-riscv64-unknown-elf \
  libevent-dev \
  libjson-c-dev \
  sudo \
  universal-ctags \
  vim \
  zlib1g-dev

# Add normal user
ARG UID=1000
ARG GID=1000
ARG USER=jian
ENV EDITEOR=vim
RUN useradd -u $UID -g $GID -m $USER
RUN echo "$USER	ALL=(ALL:ALL) NOPASSWD:SETENV:/usr/bin/apt,/usr/bin/apt-get" >> /etc/sudoers
RUN chown -R $USER /opt

VOLUME ["/home/$USER"]
WORKDIR "/home/$USER"
USER $USER

# Setup conda environment
COPY --chown=$UID:$GID environment.yml /tmp
RUN conda config --add channels LiteX-Hub
RUN mamba env update --file /tmp/environment.yml && rm /tmp/environment.yml

# FPGA toolchain from YosysHQ
ARG TARGETARCH=arm64
ARG TARGETOS=linux
RUN wget -O - https://github.com/YosysHQ/oss-cad-suite-build/releases/download/`date +'%Y-%m-%d'`/oss-cad-suite-$TARGETOS-$TARGETARCH-`date +'%Y%m%d'`.tgz \
  | tar -C /opt -zxf -
RUN echo "export PATH=/opt/oss-cad-suite/bin:\$PATH" >> ~/.bashrc

# Litex
RUN mkdir /opt/fpga
RUN git -C /opt/fpga clone https://github.com/enjoy-digital/litex.git
RUN cd /opt/fpga/litex && ./litex_setup.py install --init

# Amaranth
RUN git -C /opt/fpga clone https://github.com/amaranth-lang/amaranth.git
RUN git -C /opt/fpga clone https://github.com/amaranth-lang/amaranth-boards.git
RUN cd /opt/fpga/amaranth && python setup.py develop
RUN cd /opt/fpga/amaranth-boards && python setup.py develop
RUN rm -rf /opt/fpga/amaranth*/nmigen*

# Almond for Scala notebook
RUN wget -O coursier https://git.io/coursier-cli
RUN chmod +x coursier
RUN ./coursier launch --fork almond:0.10.0 --scala 2.12.11 -- --install

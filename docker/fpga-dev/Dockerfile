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

# FPGA toolchain from YosysHQ
RUN ARCH=`arch`; [ "$ARCH" = "x86_64" ] && ARCH=x64; wget -O - https://github.com/YosysHQ/oss-cad-suite-build/releases/download/`date +'%Y-%m-%d'`/oss-cad-suite-linux-$ARCH-`date +'%Y%m%d'`.tgz \
  | tar -C /opt -zxf -
RUN echo "export PATH=\$PATH:/opt/oss-cad-suite/bin" >> /etc/bash.bashrc
ENV VERILATOR_ROOT="/opt/oss-cad-suite/share/verilator"
ENV GHDL_PREFIX="/opt/oss-cad-suite/lib/ghdl"

# Update conda base
COPY environment.yml /tmp
RUN conda config --add channels LiteX-Hub
RUN mamba env update --file /tmp/environment.yml && rm /tmp/environment.yml

# Litex
RUN mkdir /opt/fpga
RUN git -C /opt/fpga clone https://github.com/enjoy-digital/litex.git
RUN cd /opt/fpga/litex && ./litex_setup.py install --init

# Create the user
ARG USERNAME=jian
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
  && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
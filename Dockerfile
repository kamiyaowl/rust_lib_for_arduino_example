FROM rust:1.37.0-buster

RUN rustup install nightly
RUN rustup default nightly

RUN apt-get update
RUN apt-get install -y gcc g++ gcc-arm-none-eabi zip
RUN rustup target add thumbv6m-none-eabi thumbv7m-none-eabi thumbv7em-none-eabi thumbv7em-none-eabihf

RUN mkdir /work
WORKDIR /work

CMD ["/bin/sh"]
#!/bin/bash

export DEBIAN_FRONTEND="noninteractive"
apt-get update && apt-get install --yes --no-install-recommends apt-utils ca-certificates &&
    apt-get --yes upgrade && apt-get install --yes --no-install-recommends sudo wget curl

export RUSTUP_HOME=/usr/local/rustup
export CARGO_HOME=/usr/local/cargo
export PATH=/usr/local/cargo/bin:$PATH

DEFAULT_RUST_VERSION=1.61.0
DEFAULT_RUSTUP_VERSION=1.24.3
RUST_VERSION=${1:-$DEFAULT_RUST_VERSION}
RUSTUP_VERSION=${2:-$DEFAULT_RUSTUP_VERSION}

set -eux
dpkgArch="$(dpkg --print-architecture)"

case "${dpkgArch##*-}" in
amd64)
    rustArch='x86_64-unknown-linux-gnu'
    rustupSha256='3dc5ef50861ee18657f9db2eeb7392f9c2a6c95c90ab41e45ab4ca71476b4338'
    ;;
armhf)
    rustArch='armv7-unknown-linux-gnueabihf'
    rustupSha256='67777ac3bc17277102f2ed73fd5f14c51f4ca5963adadf7f174adf4ebc38747b'
    ;;
arm64)
    rustArch='aarch64-unknown-linux-gnu'
    rustupSha256='32a1532f7cef072a667bac53f1a5542c99666c4071af0c9549795bbdb2069ec1'
    ;;
i386)
    rustArch='i686-unknown-linux-gnu'
    rustupSha256='e50d1deb99048bc5782a0200aa33e4eea70747d49dffdc9d06812fd22a372515'
    ;;
*)
    echo >&2 "unsupported architecture: ${dpkgArch}"
    exit 1
    ;;
esac

url="https://static.rust-lang.org/rustup/archive/${RUSTUP_VERSION}/${rustArch}/rustup-init"
wget "$url"
echo "${rustupSha256} *rustup-init" | sha256sum -c -
chmod +x rustup-init

./rustup-init -y --no-modify-path --profile minimal --default-toolchain "$RUST_VERSION" --default-host ${rustArch}

rm rustup-init
chmod -R a+w "$RUSTUP_HOME" "$CARGO_HOME"

rustup --version
cargo --version
rustc --version

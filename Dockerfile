FROM ubuntu

ARG release=1.6

WORKDIR /kart

# Install dependencies
RUN apt-get update \
    && apt-get install -y build-essential git p7zip-full p7zip-rar nasm libpng-dev zlib1g-dev libsdl2-dev libsdl2-mixer-dev libgme-dev libopenmpt-dev libcurl4-openssl-dev wget unzip

# Download release source code and extract in-place
RUN wget -qO- https://github.com/STJr/Kart-Public/archive/refs/tags/v${release}.tar.gz | tar xvz \
    # Enter directory and build
    && cd Kart-Public-${release} \
    && make -C src/ LINUX64=1 \
    # Move built files to /kart
    && mv bin/Linux64/Release/* /kart \
    # Download and extract assets
    && cd /kart \
    && wget https://github.com/STJr/Kart-Public/releases/download/v${release}/AssetsLinuxOnly.zip \
    && unzip AssetsLinuxOnly.zip \
    && rm AssetsLinuxOnly.zip

CMD /kart/lsdl2srb2kart -dedicated
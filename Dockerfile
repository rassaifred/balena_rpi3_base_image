FROM balenalib/raspberrypi3-debian:stretch-run-20190612

MAINTAINER rassaifred

RUN [ "cross-build-start" ]

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  htop \
  build-essential \
  python3-setuptools \
  python3-rpi.gpio \
  python-dev \
  python3-dev \
  fbset \
  dbus \
  libglib2.0-dev \
  libdbus-1-3 \
  libdbus-1-dev \
  python-dbus \
  python3-dbus \
  libjpeg-dev \
  libopenjp2-7 \
  zlib1g \
  python3-dev \
  python-imaging \
  python-smbus \
  i2c-tools \
  python3-pil \
  git \
  omxplayer \
  x11-xserver-utils \
  xserver-xorg && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py

COPY requirements.txt ./

RUN pip3 install --upgrade setuptools

RUN pip3 install --no-cache-dir -r requirements.txt

# Enable udevd so that plugged dynamic hardware devices show up in our container.
ENV UDEV=1
ENV DBUS_SYSTEM_BUS_ADDRESS unix:path=/host/run/dbus/system_bus_socket

RUN [ "cross-build-end" ]

FROM resin/raspberrypi-python

# Enable systemd
ENV INITSYSTEM on

# Install Python.
RUN apt-get update \
	&& apt-get install -y python git build-essential python-dev python-smbus python-imaging \
	# Remove package lists to free up space
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir /tmp/adafruit \
        && cd /tmp/adafruit \
	&& git clone https://github.com/adafruit/Adafruit_Python_LED_Backpack.git \
	&& cd Adafruit_Python_LED_Backpack \
	&& python ./setup.py install

RUN echo "install complete"

# copy current directory into /app
COPY . /app

# run python script when container lands on device
CMD ["python", "/app/hello.py"]

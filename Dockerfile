FROM debian:bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
	bash \
	curl \
	file \
	git \
	unzip \
	which \
	xz-utils \
	zip \
	&& rm -rf /var/lib/apt/lists/*

ARG USER_NAME=ittae

RUN useradd -ms /bin/sh $USER_NAME
USER $USER_NAME

ARG FLUTTER_SDK=/home/$USER_NAME/flutter

# Install Flutter
RUN git clone -b master https://github.com/flutter/flutter.git $FLUTTER_SDK

# Add Flutter to PATH
ENV PATH="$FLUTTER_SDK/bin:$PATH"

# Run basic check to download Dark SDK
RUN flutter precache --web

# Set the working directory in the container
WORKDIR /app

# Copy the pubspec.yaml and pubspec.lock to the container
COPY --chown=ittae:ittae pubspec.yaml pubspec.lock ./

# Install dependencies
RUN flutter clean
RUN flutter pub get

# Copy source code to container
COPY --chown=ittae:ittae . .

# Build the Flutter app for the web
RUN flutter build web

CMD [ "flutter", "run", "-d", "web-server", "--web-port", "8080", "--web-hostname", "0.0.0.0" ]


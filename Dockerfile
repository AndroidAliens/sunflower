# Install linux distro
FROM ubuntu:18.04
ENV TZ=Africa/Johannesburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
WORKDIR project/
SHELL ["/bin/bash", "-c"]


# Install dependencies
RUN DEBIAN_FRONTEND=noninteractive apt update && apt install -y openjdk-8-jdk git unzip wget

RUN useradd -ms /bin/bash admin

RUN chown -R admin:admin $ANDROID_HOME
USER admin

# Gradle, API and Build Tools versions, update as neeeded
ARG ANDROID_API_LEVEL=30
ARG ANDROID_BUILD_TOOLS_LEVEL=29.0.3

# Install android build tools
RUN wget 'https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip' -P /tmp \
&& unzip -d /opt/android /tmp/sdk-tools-linux-4333796.zip \
&& yes Y | /opt/android/tools/bin/sdkmanager --install "platform-tools" "platforms;android-${ANDROID_API_LEVEL}" "build-tools;${ANDROID_BUILD_TOOLS_LEVEL}" \
&& yes Y | /opt/android/tools/bin/sdkmanager --licenses

ENV ANDROID_HOME=/opt/android
ENV PATH "$PATH:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"
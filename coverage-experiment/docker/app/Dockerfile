FROM openjdk:8-jdk

# Copy the build result to the home directory of the root account.
COPY build/libs/coverage-experiment*-all.jar /root/coverage-experiment-all.jar

# Add a simple script that allows for easy invocation.
COPY docker/app/coverage-experiment.sh /usr/local/bin/ce
RUN chmod 700 /usr/local/bin/ce

# Copy the wait-for-it script to the home directory of the root account,
# and allow it to execute. Used to run the app only after the database has loaded.
COPY docker/app/wait-for-it.sh /root/
RUN chmod 700 /root/wait-for-it.sh

# Install Gradle
# via https://github.com/keeganwitt/docker-gradle/blob/master/jdk8/Dockerfile
ENV GRADLE_HOME /opt/gradle
ENV GRADLE_VERSION 4.8.1
ARG GRADLE_DOWNLOAD_SHA256=af334d994b5e69e439ab55b5d2b7d086da5ea6763d78054f49f147b06370ed71
RUN set -o errexit -o nounset \
    && echo "Downloading Gradle" \
    && wget --no-verbose --output-document=gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" \
    \
    && echo "Checking download hash" \
    && echo "${GRADLE_DOWNLOAD_SHA256} *gradle.zip" | sha256sum --check - \
    \
    && echo "Installing Gradle" \
    && unzip gradle.zip \
    && rm gradle.zip \
    && mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" \
    && ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle \
    \
    && mkdir ~/.gradle

FROM openjdk:8u171-jre-slim-stretch

# Copy the build result to the home directory of the root account.
COPY build/libs/coverage-experiment*-all.jar /root/coverage-experiment-all.jar

# Add a simple script that allows for easy invocation.
RUN echo '#!/bin/sh\njava -jar /root/coverage-experiment-all.jar "$@"\n' > /usr/local/bin/ce && \
    chmod 700 /usr/local/bin/ce

# Copy the wait-for-it script to the home directory of the root account,
# and allow it to execute. Used to run the app only after the database has loaded.
COPY docker/app/wait-for-it.sh /root/
RUN chmod 700 /root/wait-for-it.sh

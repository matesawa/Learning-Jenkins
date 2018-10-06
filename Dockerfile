FROM ubuntu:bionic
ADD ./ /app
WORKDIR /app
ENTRYPOINT [ "./program.sh" ]
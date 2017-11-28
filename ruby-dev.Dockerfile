FROM ubuntu:xenial

RUN mkdir -p /wrom 
WORKDIR /wrom

COPY . /wrom

RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y ruby-full
RUN apt-get install -y libz-dev
RUN apt-get install -y libiconv-hook1
RUN apt-get install -y libiconv-hook-dev
RUN apt-get install -y libsqlite3-dev
RUN gem install rails
RUN gem install gemrat
RUN bundler install

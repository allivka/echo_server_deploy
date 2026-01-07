FROM  gcc:latest

WORKDIR /app

RUN git clone https://github.com/axboe/liburing
RUN cd liburing && ./configure
RUN make
RUN make install

RUN cd .. && rm -rf io_uring-echo-server

RUN git clone https://github.com/frevib/io_uring-echo-server.git
RUN cd io_uring-echo-server && make io_uring_echo_server
RUN mv io_uring_echo_server ../io_uring_echo_server
RUN cd .. && rm -rf io_uring-echo-server

EXPOSE 8081

CMD [ "./io_uring_echo_server", "8001" ]
FROM amazonlinux

WORKDIR /ml

COPY Anaconda3-2020.02-Linux-x86_64.sh .
COPY get-pip.py .

RUN bash Anaconda3-2020.02-Linux-x86_64.sh -b
RUN rm Anaconda3-2020.02-Linux-x86_64.sh

RUN python get-pip.py
RUN yum install -y git \
    && yum install -y gcc \
    && yum install -y python3 \
    && yum install -y python3-pip \
    && yum install -y postgresql-devel
    

RUN pip3 install mlflow \
    && pip3 install scikit-learn \
    && pip3 install psycopg2-binary

RUN cd /ml && git clone https://github.com/mlflow/mlflow

RUN rm -f /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python   

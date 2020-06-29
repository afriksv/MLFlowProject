FROM amazonlinux

WORKDIR /ml

RUN yum install wget -y
RUN wget https://repo.continuum.io/archive/Anaconda3-2020.02-Linux-x86_64.sh
RUN bash Anaconda3-2020.02-Linux-x86_64.sh -b
RUN rm Anaconda3-2020.02-Linux-x86_64.sh

RUN wget https://bootstrap.pypa.io/get-pip.py
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

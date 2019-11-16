# 获取Qiime2最新镜像，进行后续安装
FROM qiime2/core:2019.10

# 作者和邮箱
MAINTAINER ddhmed dfw_bioinfo@126.com

# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook

#RUN cd ../tmp && \
#    wget http://downloads.sourceforge.net/infozip/unzip552.tar.gz && \
#    tar zxvf unzip552.tar.gz && \
#    cd unzip-5.52/ && \
#    cp unix/Makefile ./ && \
#    make generic && \
#    make install

# install the PyGithub
RUN pip install PyGithub

# copy file
#ADD picrust2-2.0.3-b.tar /tmp
ADD q2-picrust2-0.0.1.tar /tmp

# install picrust2
RUN cd ../tmp && \
    wget https://github.com/picrust/picrust2/releases/download/v2.0.3-b/picrust2-2.0.3-b.zip && \
    unzip picrust2-2.0.3-b.zip && \
    cd picrust2-2.0.3-b && \
    conda-env update -n qiime2-2019.10 -f picrust2-env.yaml && \
    pip install --editable .

RUN cd ../tmp/q2-picrust2-0.0.1 && \
    python setup.py install && \
    qiime dev refresh-cache

# 删除临时文件
#RUN cd ../temp && \
#    rm -rf *

# 添加notebook配置文件（本地使用）
#ADD jupyter_notebook_config.py /home/qiime2/.jupyter/

# create user with a home directory (Binder使用)
ARG NB_USER=qiime2
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

#启动notebook（本地使用）
#CMD /bin/bash
#CMD jupyter notebook --allow-root

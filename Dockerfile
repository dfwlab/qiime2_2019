# 获取Qiime2最新镜像，进行后续安装
FROM qiime2/core:2019.10

# 作者和邮箱
MAINTAINER ddhmed dfw_bioinfo@126.com

RUN conda install python=3.6

# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook
    
# install the PyGithub
RUN pip install PyGithub

#ADD picrust2-2.0.3-b.tar /tmp
#ADD q2-picrust2-0.0.1.tar /tmp

# install picrust2
RUN conda install -c bioconda -c conda-forge picrust2=2.2.0_b
#RUN cd ../tmp && \
#    wget http://sh-ctfs.ftn.qq.com/ftn_handler/cd473c12e5ffe24f36c88a0f727ca9255666a05b3eeae92ecf666603b280548f71e66d1f30a343a1ec18a5b25eed597fabefff61c315c65bb8dbf4c5829acb0d/?fname=picrust2-2.0.3-b.tar && \
#    mv index.html?fname=picrust2-2.0.3-b.tar picrust2-2.0.3-b.tar &&\
#    tar -xvf picrust2-2.0.3-b.tar && \
#    cd picrust2-2.0.3-b && \
#    conda-env update -n qiime2-2019.10 -f picrust2-env.yaml && \
#    pip install --editable .

#RUN conda install -c gavinmdouglas q2-picrust2=2019.7
#RUN qiime dev refresh-cache
RUN cd ../tmp && \
    wget https://github.com/gavinmdouglas/q2-picrust2/archive/master.tar.gz && \
    tar xvzf master.tar.gz && \
    cd q2-picrust2-master && \
    python setup.py install && \
    qiime dev refresh-cache
    
#RUN cd ../tmp/q2-picrust2-0.0.1 && \
#    python setup.py install && \
#    qiime dev refresh-cache

# create user with a home directory (Binder使用)
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# copy file
COPY mouse_tutorial ${HOME}/mouse_tutorial
COPY mouse_result ${HOME}/mouse_result
COPY qiime_viwer.py ${HOME}

RUN chmod 777 ${HOME}/mouse_result && \
    chmod 777 ${HOME}/mouse_tutorial && \
    chmod 777 ${HOME}/qiime_viwer.py

WORKDIR ${HOME}
USER ${USER}

# 删除临时文件
#RUN cd ../temp && \
#    rm -rf *

# 添加notebook配置文件（本地使用）
#ADD jupyter_notebook_config.py /home/qiime2/.jupyter/

#启动notebook（本地使用）
#CMD /bin/bash
#CMD jupyter notebook --allow-root

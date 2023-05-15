# TYC服务器镜像
# 启动命令：
#    survival: docker run --rm -itd --name="survival" --net=host -h="survival" --expose 25566 -v /root/server/survival:/mcdreforged -v /etc/localtime:/etc/localtime optijava/tyc-server:v1.0
#    creative: docker run --rm -itd --name="creative" --net=host -h="creative" --expose 25567 -v /root/server/creative:/mcdreforged -v /etc/localtime:/etc/localtime optijava/tyc-server:v1.0
#    velocity: docker run --rm -itd --name="vel" --net=host -h="velocity" --expose 25565 -v /root/server/vel:/mcdreforged -v /etc/localtime:/etc/localtime optijava/tyc-server:v1.0


FROM python:3.11.3


COPY ./requirements.txt /requirements.txt


WORKDIR /mcdreforged


RUN cd / \
    && wget https://ghproxy.net/https://github.com/dragonwell-project/dragonwell17/releases/download/dragonwell-standard-17.0.6.0.6%2B9_jdk-17.0.6-ga/Alibaba_Dragonwell_Standard_17.0.6.0.6.9_x64_linux.tar.gz \
    && tar -xf Alibaba_Dragonwell_Standard_17.0.6.0.6.9_x64_linux.tar.gz \
    && rm -f Alibaba_Dragonwell_Standard_17.0.6.0.6.9_x64_linux.tar.gz \
    && update-alternatives --install /usr/bin/java java /dragonwell-17.0.6.0.6+9-GA/bin/java 1 \
    && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && python3 -m pip install -r /requirements.txt \
    && python3 -m pip install --upgrade pip \
    && cd /mcdreforged \
    && python3 -m mcdreforged init


ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED 0


CMD python3 -X utf8 -m mcdreforged

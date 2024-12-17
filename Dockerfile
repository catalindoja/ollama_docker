FROM tensorflow/tensorflow:2.18.0-gpu-jupyter
# overall I chose this image because the GPU CUDA libraries work properly with this image and the jupyter notebook is always nice to have

WORKDIR /workspace

EXPOSE 8888
EXPOSE 11434

# Set non-interactive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y curl

RUN pip install scikit-learn

RUN pip install pandas

RUN pip install matplotlib

RUN pip install numpy

RUN pip install opencv-python

RUN pip install jupyterlab

RUN apt install python-is-python3 -y

# install the replacement of systemctl for docker
# this is rather necessary as for the explaination of why check: 
# https://github.com/gdraheim/docker-systemctl-replacement/blob/master/README.md
COPY systemctl3.py /usr/bin/systemctl

RUN chmod +x /usr/bin/systemctl

RUN test -e /bin/systemctl || ln -sf /usr/bin/systemctl /bin/systemctl

RUN curl -fsSL https://ollama.com/install.sh | sh

ENV OLLAMA_HOST=0.0.0.0

# enable ollama
RUN systemctl daemon-reload
RUN systemctl enable ollama
RUN systemctl start ollama

COPY start-ollama.sh .
RUN chmod +x start-ollama.sh
RUN ./start-ollama.sh


CMD ["systemctl", "start", "ollama"]
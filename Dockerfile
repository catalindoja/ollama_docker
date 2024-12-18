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

RUN pip install ollama

RUN pip install rich

RUN pip install requests

RUN pip install argparse

RUN apt install python-is-python3 -y

RUN curl -fsSL https://ollama.com/install.sh | sh

ENV OLLAMA_HOST=0.0.0.0

COPY pull_ollama_model.sh .
RUN chmod +x pull_ollama_model.sh
RUN ./pull_ollama_model.sh

RUN chmod -R 777 /root/.ollama

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]
# Must use a Cuda version 11+
FROM pytorch/pytorch:1.11.0-cuda11.3-cudnn8-runtime

WORKDIR /

# Install git and wget
RUN apt-get update && apt-get install -y git wget

# Upgrade pip
RUN pip install --upgrade pip

# Set the CUDA architecture list
ENV TORCH_CUDA_ARCH_LIST="8.0;8.6;8.6+PTX;8.9;9.0"

# Install AutoGPTQ from source
RUN pip3 uninstall -y auto-gptq && \
    git clone https://github.com/PanQiWei/AutoGPTQ && \
    cd AutoGPTQ && \
    auto_gptq-0.3.2+cu117-cp38-cp38-linux_x86_64.whl
 && \
    pip3 install .

ADD requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# Add your model weight files 
ADD download.py .
RUN python3 download.py

ADD . .

EXPOSE 8000

CMD python3 -u app.py

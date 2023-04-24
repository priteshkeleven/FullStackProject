FROM ubuntu:22.04
ENV PATH="/root/miniconda3/bin:$PATH"
ARG PATH="/root/miniconda3/bin:$PATH"

RUN apt-get update

RUN apt-get install -y wget build-essential curl git

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN mkdir /root/.conda
RUN bash Miniconda3-latest-Linux-x86_64.sh -b
RUN rm -f Miniconda3-latest-Linux-x86_64.sh 

RUN conda --version
RUN conda config --add channels conda-forge

ADD . .

RUN conda env create -n obb --file build/conda/conda-3-9-env.yaml
SHELL ["conda", "run", "-n", "obb", "/bin/bash", "-c"]

RUN poetry install -E all

EXPOSE 8501

CMD ["conda", "run", "-n", "obb", "python", "terminal.py", "--streamlit"]
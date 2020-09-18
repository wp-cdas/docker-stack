FROM cdasdsp/base-notebook:latest

### Install tensorflow
# Install Tensorflow
USER $NB_UID

RUN conda install --quiet --yes \
    'tensorflow-gpu=2.2.*' \
    'keras=2.4.*' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER


## End install tensorflow
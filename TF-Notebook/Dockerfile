FROM cdasdsp/minimal-notebook:latest

USER $NB_UID

RUN conda install --quiet --yes \
    'tensorflow-gpu=2.2.*' \
    'keras' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER


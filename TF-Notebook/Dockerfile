FROM cdasdsp/minimal-notebook:latest

USER $NB_UID

RUN pip install tensorflow-gpu \
    keras && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

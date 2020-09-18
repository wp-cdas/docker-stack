FROM cdasdsp/scipy-notebook:latest

USER $NB_UID

RUN conda install --quiet --yes \
    'tensorflow-gpu=2.1.*' \
    'keras=2.4.*' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER


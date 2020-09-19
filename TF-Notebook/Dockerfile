FROM cdasdsp/minimal-notebook:tf-base

USER $NB_UID

# RUN conda install --quiet --yes -c conda-forge \
#     'tensorflow-gpu=2.2.*' && \
#     #'keras' && \
#     conda clean --all -f -y && \
#     fix-permissions $CONDA_DIR && \
#     fix-permissions /home/$NB_USER

RUN pip install tensorflow-gpu \
    keras && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

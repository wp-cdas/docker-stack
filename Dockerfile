FROM cdasdsp/datasci-rstudio-notebook:latest

USER root
RUN apt-get update && \
        apt-get install -y --no-install-recommends \
                htop

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy local files as late as possible to avoid cache busting
COPY start.sh start-notebook.sh start-singleuser.sh /usr/local/bin/
COPY jupyter_notebook_config.py /etc/jupyter/

# Fix permissions on /etc/jupyter as root
USER root

RUN chmod +x /usr/local/bin/start-notebook.sh
RUN fix-permissions /etc/jupyter/

#Be a good GPU neighbor
RUN export TF_FORCE_GPU_ALLOW_GROWTH=TRUE

USER $NB_UID

COPY ./CAUTION.txt /home/dspuser/

WORKDIR $HOME

EXPOSE 8888

# Configure container startup
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-notebook.sh"]


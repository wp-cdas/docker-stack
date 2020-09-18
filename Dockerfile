FROM cdasdsp/datasci-notebook:latest

### Install RStudio Server and supporting proxy
# You can use rsession from rstudio's desktop package as well.

USER root 

RUN apt-get update && \
        apt-get install -y --no-install-recommends \
                libapparmor1 \
                libedit2 \
                lsb-release \
                psmisc \
                libssl1.0.0 \
                libclang-dev \
                ;

ENV RSTUDIO_PKG=rstudio-server-1.3.959-amd64.deb

RUN wget -q http://download2.rstudio.org/server/bionic/amd64/${RSTUDIO_PKG}
RUN dpkg -i ${RSTUDIO_PKG}
RUN rm ${RSTUDIO_PKG}

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*


USER $NB_USER

RUN conda install --quiet --yes \
    jupyter-server-proxy \
    jupyter-rsession-proxy && \
    jupyter labextension install @jupyterlab/server-proxy && \
    jupyter lab build

# The desktop package uses /usr/lib/rstudio/bin
ENV PATH="${PATH}:/usr/lib/rstudio-server/bin"
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/lib:/usr/lib/x86_64-linux-gnu:/opt/conda/lib/R/lib"

### End install RStudio Server

### Octave Install
RUN conda install --quiet --yes \
    'octave_kernel' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
### End install Octave

### Install jupyterlab-git extension
RUN conda install --quiet --yes -c conda-forge jupyterlab-git && \
    jupyter lab build
### End install jupyterlab-git

EXPOSE 8888

# Configure container startup
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-notebook.sh"]

# Copy local files as late as possible to avoid cache busting
COPY start.sh start-notebook.sh start-singleuser.sh /usr/local/bin/
COPY jupyter_notebook_config.py /etc/jupyter/

# Fix permissions on /etc/jupyter as root
USER root
RUN chmod +x /usr/local/bin/start-notebook.sh
RUN fix-permissions /etc/jupyter/

COPY ./CAUTION.txt /home/dspuser/

# 7 JULY 2020 Additions - Added here to stop cache busting
RUN apt-get update && \
        apt-get install -y --no-install-recommends \
                curl

RUN conda install --quiet --yes \
    'r-rstan' \
    'r-tmb' 

RUN R -e "r = getOption('repos'); \
          r['CRAN'] = 'http://cran.us.r-project.org'; \
          options(repos = r); \
          install.packages('INLA', repos=c(getOption('repos'), INLA='https://inla.r-inla-download.org/R/stable'), dep=TRUE);"

RUN julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'import Pkg; Pkg.add(["JuliaDB", "Plots", "Flux", "Genie", "JuMP", "Knet", "IterTools", "MLDatasets"])'

USER $NB_UID

WORKDIR $HOME


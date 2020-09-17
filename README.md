# docker-stacks
JupyterLab Docker-Stack for DSP

This stack is built in parts that roughly mirror the official stacks available from Jupyter. The difference is that this base stack is built off of a NVIDIA image that includes CUDA/CUDNN support. I've also added a few custom touches for the DSP.

 The order of stack goes:  
 -Base  
 -TF
 -Minimal  
 -Scipy  
 -Datasci 

The final image is dictated by the Dockerfile in the top directory and is called: datasci-rstudio-notebook.

The GitHub Actions workflow associated with this repository builds the image upon a pull request and then build and pushes the image upon a successful merge into the master branch. The image is tagged with a "short SHA" from the commit. This "short SHA" acts as the version number for the image and must be placed into the JupyterHub config before the new image will be pulled by JupyterHub.  This means that the JupyterHub service on the DSP must be restarted so it re-reads the config file.

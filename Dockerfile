
ARG SOURCE_IMAGE=$SOURCE_IMAGE
FROM $SOURCE_IMAGE

COPY . /clawpack

## install Clawpack
ENV CLAW=/clawpack
ENV NETCDF4_DIR=/opt/conda
ENV FC=gfortran
ENV MPLBACKEND=Agg

# this is needed to find libraries when building geoclaw (particularly lapack)
ENV LIB_PATHS=/opt/conda/lib

WORKDIR /clawpack

# need to change shell in order for source command to work
SHELL ["/bin/bash", "-c"]

RUN conda update -n base conda

RUN if [[ -d /opt/conda/envs/worker ]]; then source activate worker; fi;

# install clawpack
RUN pip install -e .

# install pytides
RUN source activate worker && \
  pip install git+https://github.com/maritimeplanning/pytides.git@master \
    --no-cache-dir

# install nose
RUN conda install -yc conda-forge nose

WORKDIR /

ENTRYPOINT ["tini", "--", "/usr/bin/prepare.sh"]

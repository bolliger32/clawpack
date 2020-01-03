
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

# super sketchy hack to get around our need for compiler_compat binaries and some
# other things that cause problems together?
# see https://github.com/ContinuumIO/anaconda-issues/issues/11152
##
# This duplicated from RhodiumGroup/docker_images:common.sh because the files seem
# to be re-introduced by conda commands
rm -rf /opt/conda/compiler_compat/ld

# install clawpack
RUN pip install -e .

# install pytides
RUN pip install git+https://github.com/maritimeplanning/pytides.git@master \
      --no-cache-dir

# install nose
RUN conda install -yc conda-forge nose

WORKDIR /

ENTRYPOINT ["tini", "--", "/usr/bin/prepare.sh"]

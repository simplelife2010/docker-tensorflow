FROM balenalib/armv7hf-debian-python:3.7-build as buildstep

ENV PATH="/venv/bin:$PATH"
ENV TENSORFLOW_VERSION="2.2.0"
ENV PYTHON_VERSION="37"
ENV TENSORFLOW_WHEEL="tensorflow-${TENSORFLOW_VERSION}-cp${PYTHON_VERSION}-none-linux_armv7l.whl"

RUN python3 -m venv /venv
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade setuptools
#RUN install_packages libfreetype6-dev libpng-dev libhdf5-dev
#RUN install_packages liblapack-dev libblas-dev
#RUN install_packages libnetcdf-dev
RUN wget -q https://github.com/lhelontra/tensorflow-on-arm/releases/download/v${TENSORFLOW_VERSION}/${TENSORFLOW_WHEEL}
RUN pip3 install ${TENSORFLOW_WHEEL}
RUN install_packages gfortran
RUN pip3 install scipy
RUN install_packages cython3

FROM balenalib/armv7hf-debian-python:3.7-run
COPY --from=buildstep /venv /venv
ENV PATH="/venv/bin:$PATH"

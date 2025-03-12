# Use AlmaLinux as the base image
FROM almalinux:9

# Set ARG for Python version and other optional platform-specific variables
ARG python=3.9
ARG releasev0
ARG TARGETPLATFORM

ENV PYTHON_VERSION=${python}

# Installation of system packages
RUN yum -y install epel-release \
    && yum -y update \
    && yum -y --allowerasing install wget git bzip2 libgfortran which zsh emacs vim htop man man-pages \
    && curl -fsSLo Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh" \
    && bash Miniforge3.sh -bfp /usr/local \
    && rm -rf Miniforge3.sh \
    && mamba update mamba \
    && mamba clean --all --yes \
    && yum clean all

# Copy environment YAML files to the container (replace with your actual environment files)
COPY environment.yaml /environment.yaml
COPY environment-aarch64.yaml /environment-aarch64.yaml

# Install Python and environment packages using mamba/conda
RUN if [ "${TARGETPLATFORM}" == "linux/arm64" ]; then \
        export G_SLICE=always-malloc \
        && mamba install --yes python=${PYTHON_VERSION} \
        && mamba env update --file /environment-aarch64.yaml \
        && mamba clean -y --all ; \
    else \
        mamba install --yes python=${PYTHON_VERSION} \
        && mamba env update --file /environment.yaml \
        && mamba clean -y --all; \
    fi

RUN pip install -r /requirements.txt

# Make a symbolic link between installation /opt/conda/etc/grid-security and actual directory /etc/grid-security
RUN ln -s /usr/local/etc/grid-security /etc/grid-security && \
    curl -L https://github.com/opensciencegrid/osg-vo-config/archive/refs/heads/master.tar.gz | \
    tar -xz --strip-components=1 --directory=/etc/grid-security --wildcards */vomses */vomsdir && \
    mv /etc/grid-security/vomses /etc

# Copy your Python application files into the container
COPY . /app

# Set the working directory to /app where your application resides
WORKDIR /app

# Expose the port your app will be running on (e.g., 5000 for web app)
EXPOSE 5000

# Define the entrypoint for your application (adjust according to your app's main script)
CMD ["python", "generate-data-yolo-sh.py"]

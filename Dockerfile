# Create a base docker container that will run bet/bet2


# Install FSL
FROM neurodebian:trusty
MAINTAINER Hakim Achterberg <h.achterberg@erasmusmc.nl>

# Run apt-get calls
COPY sources /etc/apt/sources.list.d/neurodebian.sources.list
RUN apt-get update \
    && apt-get install -y fsl-5.0-core

# Configure environment (Must also be done it the RUN script)
ENV FSLDIR=/usr/lib/fsl/5.0
ENV FSLOUTPUTTYPE=NIFTI_GZ
ENV PATH=$PATH:$FSLDIR
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$FSLDIR
RUN echo ". /etc/fsl/5.0/fsl.sh" >> /root/.bashrc

# Create symlink to make sure there is a bin directory
RUN ln -s /usr/lib/fsl/5.0 /usr/lib/fsl/5.0/bin

# Configure entrypoint
ENTRYPOINT ["/usr/lib/fsl/5.0/bet"]

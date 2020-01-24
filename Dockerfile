FROM python:3.7

# Install the dependencies for R
RUN apt-get update && apt-get install -y r-base r-base-dev r-recommended
RUN Rscript -e "install.packages('ggrepel')"
RUN Rscript -e 'source("http://bioconductor.org/biocLite.R")' -e 'biocLite("edgeR")'

WORKDIR /opt/app/
ADD ./ ./

# Add all of the scripts to the /opt/app/ path inside of the image
#ADD . /opt/app/

# Change the working directory inside of the image to /opt/app/
#WORKDIR /opt/app/

# Install the python dependencies in /opt/app/requirements.txt using pip
RUN pip3.7 install -r ./requirements.txt

# This command just shows info about the contents of the image. It doesn't run any
# scripts, since that will be done _AFTER_ the image is built.
CMD pwd && ls -AlhF ./

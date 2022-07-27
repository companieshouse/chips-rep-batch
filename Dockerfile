FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/ch-serverjre:1.2.1

ENV REP_HOME=/apps/rep \
    ARTIFACTORY_BASE_URL=http://repository.aws.chdev.org:8081/artifactory

RUN yum -y install gettext && \
    yum -y install cronie && \
    yum -y install oracle-instantclient-release-el7 && \
    yum -y install oracle-instantclient-basic && \
    yum -y install oracle-instantclient-sqlplus && \
    yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum -y install msmtp && \
#    yum -y install xmlstarlet && \
    yum clean all && \
    rm -rf /var/cache/yum

RUN mkdir -p /apps && \
    chmod a+xr /apps && \
    useradd -d ${REP_HOME} -m -s /bin/bash rep

USER rep

# Copy all batch jobs to REP_HOME
COPY --chown=rep rep-batch ${REP_HOME}/

# Download the batch libs and set permission on scripts
RUN mkdir -p ${REP_HOME}/libs && \
    cd ${REP_HOME}/libs && \
#    curl ${ARTIFACTORY_BASE_URL}/virtual-release/log4j/log4j/1.2.14/log4j-1.2.14.jar -o log4j.jar && \
    chmod -R 750 ${REP_HOME}/*

WORKDIR $REP_HOME
USER root
CMD ["bash"]
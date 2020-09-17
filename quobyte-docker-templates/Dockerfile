FROM quay.io/quobyte/quobyte-server:2
RUN yum install -y bind-utils && \
    yum clean all
COPY ./templates/RF3.cfg /RF3.cfg
COPY ./templates/RF1.cfg /RF1.cfg
COPY ./templates/EC42.cfg /EC42.cfg
COPY ./templates/S3-objects.cfg /S3-objects.cfg
COPY ./templates/system.cfg /system.cfg
COPY ./main.sh /opt/main.sh
ENV QUOBYTE_SERVICES="registry api metadata data webconsole s3"
CMD ["/opt/main.sh"]

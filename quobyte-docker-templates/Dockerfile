FROM quay.io/quobyte/quobyte-server:2
ADD ./templates/RF3.cfg /RF3.cfg
ADD ./templates/RF1.cfg /RF1.cfg
ADD ./templates/EC42.cfg /EC42.cfg
ADD ./templates/S3-objects.cfg /S3-objects.cfg
ADD ./templates/system.cfg /system.cfg
ADD ./main.sh /opt/main.sh
ENV QUOBYTE_SERVICES="registry api metadata data webconsole s3"
CMD ["/opt/main.sh"]

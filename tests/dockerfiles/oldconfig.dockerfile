FROM centos/systemd
RUN mkdir -p /etc/nginx/conf.d
RUN touch /etc/nginx/conf.d/i_am_old_and_should_be_deleted.conf

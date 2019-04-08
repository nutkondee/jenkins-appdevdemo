FROM nginx:mainline-alpine
#FROM centos/nginx-18-centos7

#USER root
#RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf
#RUN echo "nameserver 8.8.4.4" >> /etc/resolv.conf
#RUN yum -y update; yum clean all
#RUN yum -y install epel-release; yum clean all
#RUN yum -y install python-pip; yum clean all
# --- Python Installation ---
#RUN apk add --no-cache python3
#RUN yum update -y
#RUN pip3 install --upgrade pip setuptools
RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

# --- Work Directory ---
WORKDIR /usr/src/app

# --- Python Setup ---
ADD . .
RUN pip install -r requirements.pip

# --- Nginx Setup ---
COPY config/nginx/default.conf /etc/nginx/conf.d/
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx
RUN chgrp -R root /var/cache/nginx
RUN sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf
RUN addgroup nginx root

# --- Expose and CMD ---
EXPOSE 8081
CMD gunicorn --bind 0.0.0.0:5000 wsgi --chdir /usr/src/app/ & nginx -g "daemon off;"

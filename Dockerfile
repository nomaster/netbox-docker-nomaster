FROM ubuntu
RUN useradd -m netbox
WORKDIR /opt/netbox
RUN apt-get update
RUN apt-get install -y python3 python3-dev python3-setuptools build-essential libxml2-dev libxslt1-dev libffi-dev graphviz libpq-dev libssl-dev zlib1g-dev git
RUN python3 /usr/lib/python3/dist-packages/easy_install.py pip
RUN pip3 install gunicorn
RUN git clone -b master https://github.com/digitalocean/netbox.git .
RUN chown -R netbox:netbox netbox/media
RUN pip3 install -r requirements.txt
WORKDIR /opt/netbox/netbox
COPY gunicorn_config.py /opt/netbox/
COPY configuration.py /opt/netbox/netbox/netbox
CMD ["gunicorn", "-c", "/opt/netbox/gunicorn_config.py", "netbox.wsgi"]
EXPOSE 8001
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

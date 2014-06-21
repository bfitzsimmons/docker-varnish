FROM bfitzsimmons/base:latest
MAINTAINER Brant Fitzsimmons <brant.fitzsimmons@gmail.com>

# Install Varnish.
RUN curl http://repo.varnish-cache.org/debian/GPG-key.txt | apt-key add -
RUN echo "deb http://repo.varnish-cache.org/ubuntu/ trusty varnish-4.0" | tee -a /etc/apt/sources.list
RUN aptitude update
RUN aptitude -q=2 -y install varnish

# Configure Varnish.
ADD default.vcl /etc/varnish/default.vcl
ENV VARNISH_BACKEND_IP 192.168.59.103
ENV VARNISH_BACKEND_PORT 8080
ENV VARNISH_PORT 80
ENV VARNISH_MEM 512M
ADD parse_vcl.sh /parse_vcl.sh
ADD start_varnish.sh /start_varnish.sh
RUN chmod 0755 /parse_vcl.sh /start_varnish.sh
EXPOSE 80
CMD ["/start_varnish.sh"]

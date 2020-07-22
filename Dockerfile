FROM centos:7
RUN yum -y install wget git gcc gcc-c++ pcre pcre-devel zlib zlib-devel openssl openssl-devel
RUN wget http://tengine.taobao.org/download/tengine-2.3.2.tar.gz && git clone https://github.com/vozlt/nginx-module-vts.git && tar zxvf tengine-2.3.2.tar.gz
WORKDIR ./tengine-2.3.2/
RUN ./configure --prefix=/usr/local/nginx --with-stream --with-stream_ssl_module --with-stream_sni --add-module=./modules/ngx_http_footer_filter_module --add-module=./modules/ngx_http_upstream_check_module --add-module=./modules/ngx_http_upstream_consistent_hash_module --add-module=./modules/ngx_http_upstream_dynamic_module --add-module=./modules/ngx_http_upstream_vnswrr_module --add-module=../nginx-module-vts && make && make install && mkdir -p /usr/local/nginx/conf/{web,stream}
ADD  nginx.conf /usr/local/nginx/conf
EXPOSE 80
EXPOSE 443
EXPOSE 8080
CMD ["/usr/local/nginx/sbin/nginx","-g","daemon off;"]
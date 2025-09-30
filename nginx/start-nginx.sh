docker run --rm \
    -p 8080:80 \
    -p 8081:443 \
    -v "$(PWD)/default.conf":'/etc/nginx/conf.d/default.conf' \
    -v "$(PWD)/data":'/data' \
    -v "$(PWD)/tyler0ps.local.crt":'/usr/share/nginx/certs/tyler0ps.local.crt' \
    -v "$(PWD)/tyler0ps.local.key":'/usr/share/nginx/certs/tyler0ps.local.key' \
    --name nginx \
    nginx

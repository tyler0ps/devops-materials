# Intro
Setup a nginx with TLS enabled, client able to send request to nginx with rootCA cert.

Create certs follow [self-signed-certificate-with-custom-ca.md]

### Setup workspace
docker run -it --rm -w '/work/' -v `PWD`:/work/ alpine sh
apk update && apk add openssl

### Create RootCA
openssl genrsa -des3 -out rootCA.key 4096

openssl req -x509 -new -noenc -key rootCA.key -sha256 -days 1024 -out rootCA.crt

openssl x509 -in rootCA.crt -noout -dates -issuer -subject

### Create server certs

#### Key
openssl genrsa -out tyler0ps.local.key 2048

#### Certificate Signing Request (CSR)
openssl req -new -sha256 \
    -key tyler0ps.local.key \
    -subj "/C=VN/ST=Ocean City/O=ORG/OU=ORG_CENTRAL/CN=localhost" \
    -reqexts SAN \
    -config <(cat /etc/ssl/openssl.cnf <(printf "\n[SAN]\nsubjectAltName=DNS:tyler0ps.local,DNS:www.tyler0ps.local,DNS:localhost")) \
    -out tyler0ps.local.csr

openssl req -in tyler0ps.local.csr -noout -subject

#### Sign CSR, Get Certificate
openssl x509 -req \
    -extfile <(printf "subjectAltName=DNS:tyler0ps.local,DNS:www.tyler0ps.local,DNS:localhost") \
    -days 120 \
    -in tyler0ps.local.csr \
    -CA rootCA.crt \
    -CAkey rootCA.key \
    -CAcreateserial \
    -out tyler0ps.local.crt \
    -sha256

openssl x509 -in tyler0ps.local.crt -noout -subject -dates -issuer
exit;

### Start nginx server with TLS
./start-nginx.sh

docker run --rm \
    -p 8080:80 \
    -p 8081:443 \
    -v "$(PWD)/default.conf":'/etc/nginx/conf.d/default.conf' \
    -v "$(PWD)/data":'/data' \
    -v "$(PWD)/tyler0ps.local.crt":'/usr/share/nginx/certs/tyler0ps.local.crt' \
    -v "$(PWD)/tyler0ps.local.key":'/usr/share/nginx/certs/tyler0ps.local.key' \
    --name nginx \
    nginx

### Test 
curl --cacert rootCA.crt https://localhost:8081
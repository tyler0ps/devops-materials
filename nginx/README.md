# Intro
Setup a nginx with TLS enabled, client able to send request to nginx with rootCA cert.

Create certs follow [fntlnz/self-signed-certificate-with-custom-ca.md](https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309) 

### Setup workspace
```bash
docker run -it --rm -w '/work/' -v `PWD`:/work/ alpine sh
```

```bash
apk update && apk add openssl
```

### Create RootCA
```bash
openssl genrsa -des3 -out rootCA.key 4096
```
```bash
openssl req -x509 -new -noenc -key rootCA.key -sha256 -days 1024 -out rootCA.crt
openssl x509 -in rootCA.crt -noout -dates -issuer -subject
```
### Create server certs

#### Key
```bash
openssl genrsa -out tyler0ps.local.key 2048
```

#### Certificate Signing Request (CSR)
```bash
openssl req -new -sha256 \
    -key tyler0ps.local.key \
    -subj "/C=VN/ST=Ocean City/O=ORG/OU=ORG_CENTRAL/CN=localhost" \
    -reqexts SAN \
    -config <(cat /etc/ssl/openssl.cnf <(printf "\n[SAN]\nsubjectAltName=DNS:tyler0ps.local,DNS:www.tyler0ps.local,DNS:localhost")) \
    -out tyler0ps.local.csr
```
```bash
openssl req -in tyler0ps.local.csr -noout -subject
```
#### Sign CSR, Get Certificate
```bash
openssl x509 -req \
    -extfile <(printf "subjectAltName=DNS:tyler0ps.local,DNS:www.tyler0ps.local,DNS:localhost") \
    -days 120 \
    -in tyler0ps.local.csr \
    -CA rootCA.crt \
    -CAkey rootCA.key \
    -CAcreateserial \
    -out tyler0ps.local.crt \
    -sha256
```
```bash
openssl x509 -in tyler0ps.local.crt -noout -subject -dates -issuer
exit;
```
### Start nginx server with TLS
```bash
./start-nginx.sh
```
or
```bash
docker run --rm \
    -p 8080:80 \
    -p 8081:443 \
    -v "$(PWD)/default.conf":'/etc/nginx/conf.d/default.conf' \
    -v "$(PWD)/data":'/data' \
    -v "$(PWD)/tyler0ps.local.crt":'/usr/share/nginx/certs/tyler0ps.local.crt' \
    -v "$(PWD)/tyler0ps.local.key":'/usr/share/nginx/certs/tyler0ps.local.key' \
    --name nginx \
    nginx
```
### Test 
```bash
curl --cacert rootCA.crt https://localhost:8081
```

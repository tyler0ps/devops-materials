#!/bin/bash

set -e

# === CONFIG ===
CN="opensearch-cluster-master.default.svc.cluster.local"
DAYS_VALID=365

# === FILE NAMES ===
ROOT_CA_KEY="rootCA.key"
ROOT_CA_CERT="rootCA.pem"
NODE_KEY="opensearch.key"
NODE_CSR="opensearch.csr"
NODE_CERT="opensearch.pem"
CERT_CONFIG="openssl-san.cnf"

# === 1. Create openssl config with SAN ===
cat > "$CERT_CONFIG" <<EOF
[ req ]
default_bits       = 2048
prompt             = no
default_md         = sha256
req_extensions     = req_ext
distinguished_name = dn

[ dn ]
CN = $CN

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = $CN
DNS.2 = localhost
EOF

echo "[1] Generating Root CA..."
openssl genrsa -out "$ROOT_CA_KEY" 2048
openssl req -x509 -new -nodes -key "$ROOT_CA_KEY" -sha256 -days 3650 \
  -out "$ROOT_CA_CERT" -subj "/CN=MyLocalRootCA"

echo "[2] Generating OpenSearch node key + CSR..."
openssl genrsa -out "$NODE_KEY" 2048
openssl req -new -key "$NODE_KEY" -out "$NODE_CSR" -config "$CERT_CONFIG"

echo "[3] Signing CSR with Root CA to create node cert with SAN..."
openssl x509 -req -in "$NODE_CSR" \
  -CA "$ROOT_CA_CERT" -CAkey "$ROOT_CA_KEY" -CAcreateserial \
  -out "$NODE_CERT" -days "$DAYS_VALID" -sha256 \
  -extensions req_ext -extfile "$CERT_CONFIG"

echo "[4] Verifying certificate SAN..."
openssl x509 -in "$NODE_CERT" -noout -text | grep -A1 "Subject Alternative Name"

echo
echo "✅ Done. Files created:"
ls -1 "$ROOT_CA_KEY" "$ROOT_CA_CERT" "$NODE_KEY" "$NODE_CERT"

echo
echo "📌 Now you can create Kubernetes Secret using these files."

echo "opensearch.pem: " && base64 -i opensearch.pem | tr -d '\n' && echo
echo "opensearch.key: " && base64 -i opensearch.key | tr -d '\n' && echo
echo "rootCA.pem: " && base64 -i rootCA.pem | tr -d '\n' && echo

echo "📌 For Client Side"
cat rootCA.pem
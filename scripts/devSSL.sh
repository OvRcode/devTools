#!/bin/sh
# Run this script on your development machine to make sure test certificates are in place
# Make sure to trust the generated certificates on your system
generate_key () {
  echo "Generating key for $1" >> /dev/stdout
  passkey="/tmp/$i.pass.key"

  openssl genrsa -des3 -passout pass:x -out $passkey 2048

  openssl rsa -passin pass:x -in $passkey -out "/ssl/$i.key"

  rm $passkey

}

generate_signing_request () {
  echo "Generating CSR for $i" >> /dev/stdout

  openssl req -new -config "/ssl/config/$i.csr.cnf" -out "/ssl/$i.csr"
}

generate_certificate () {
  echo "Generating CERT for $i" >> /dev/stdout

  openssl x509 -req -days 3650 -in "/ssl/$i.csr" -signkey "/ssl/$i.key" -out "/ssl/$i.crt" -extensions v3_req -extfile "/ssl/config/$i.csr.cnf"
}

generate_pem () {
  echo "Generating PEM" >> /dev/stdout

  cat "/ssl/$i.crt" "/ssl/$i.key" > "/ssl/pem/$i.pem"

  echo "Make sure to trust your selfsigned certificate for $i to avoid SSL warnings" >> /dev/stdout
}

# Loop through development domains
for i in "ovrride.dev" "lists.ovrride.dev" "rockawaybeachbus.dev"
do
  if [ ! -f "/ssl/$i.key" ]; then
    generate_key $i
    generate_signing_request $i
    generate_certificate $i
    generate_pem $i
  elif [ ! -f "/ssl/$i.csr" ]; then
    generate_signing_request $i
    generate_certificate $i
    generate_pem $i
  elif [ ! -f "/ssl/$i.crt" ]; then
    generate_certificate $i
    generate_pem $i
  elif [ ! -f "/ssl/pem/$i.pem"]; then
    generate_pem $i
  else
    echo "All Files present for $i"
  fi
  # Verify key and crt match
  certfile=$(openssl x509 -noout -modulus -in $crt | openssl md5 | awk '{print $2}')
  keyfile=$(openssl rsa -noout -modulus -in $key | openssl md5 | awk '{print $2}')

  if [ $crtfile != $keyfile ]; then
    echo "Key and cert do not match for $i, regenerating" >> /dev/stdout
    generate_signing_request $i
    generate_certificate $i
  fi
done

#!/bin/bash
# Run this script on your development machine to make sure test certificates are in place
# Make sure to trust the generated certificates on your system
function generate_key() {
  echo "Generating key"
  passkey="$i.pass.key"
  openssl genrsa -des3 -passout pass:x -out $passkey 2048

  openssl rsa -passin pass:x -in $passkey -out $key

  rm $passkey

}
function generate_signing_request() {
  echo "Generating CSR"
  cnf="$csr.cnf"
  openssl req -new -config config/$cnf -out $csr
}
function generate_certificate() {
  echo "Generating CERT"
  cnf="$csr.cnf"
  openssl x509 -req -days 3650 -in $csr -signkey $key -out $crt -extensions v3_req -extfile config/$cnf
}
function generate_pem {
  echo "Generating PEM"
  cat $crt $key > $pem
}
echo "Select certificates to check:"
select cert in "local.ovrride.com" "local.rockawaybeachbus.com" "all" "none"; do
    case $cert in
        local.ovrride.com ) break;;
        local.rockawaybeachbus.com ) break;;
        all ) break;;
        none ) exit;;
    esac
done

if [ $cert == "all" ];then
  certificates[0]="local.ovrride.com"
  certificates[1]="local.rockawaybeachbus.com"
else
  certificates[0]=$cert
fi

# Start from directory of script and move from there
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR
cd ../ssl

for i in "${certificates[@]}"
do
  key="$i.key"
  csr="$i.csr"
  crt="$i.crt"
  pem="$i.pem"
  if [ ! -f $key ]; then
    generate_key
    generate_signing_request
    generate_certificate
    generate_pem
  fi
done

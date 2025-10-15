openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout ca.key -out ca.crt -subj "/C=US/ST=State/L=City/O=Root CA/CN=My Root CA"
sleep 2
openssl req -out server.csr -newkey rsa:2048 -nodes -keyout server.key -subj "/C=US/ST=State/L=City/O=amz/CN=ec2-15-207-117-54.ap-south-1.compute.amazonaws.com"
sleep 2
openssl x509 -req -sha256 -days 365 -CA ca.crt -CAkey ca.key -set_serial 0x2 -in server.csr -out server.crt -extfile san.cnf -extensions v3_req
#openssl x509 -in server.crt -text -noout

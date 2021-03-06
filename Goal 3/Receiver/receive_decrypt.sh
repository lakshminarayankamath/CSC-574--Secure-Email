#!/bin/bash

head -n +1 finalSend.txt > trim.txt
tr ',' '\n' < trim.txt > trim2.txt
rm trim.txt
head -n +1 trim2.txt > email.txt
rm trim2.txt
tr ':' '\n' < email.txt > sender.txt
rm email.txt
tail -n -1 sender.txt > email.txt

read email < email.txt
python database.py $email > certName.txt
read filename < certName.txt

#verify certificate obtained
openssl verify -CAfile root-ca.crt "$filename"

#extract email ID from the certificate
openssl x509 -in "$filename" -noout -email > email.txt
echo "Email ID of sender: " 
cat email.txt

#extract sender's public key from certificate of the sender
openssl x509 -in "$filename" -pubkey -noout > senderPublicKey.pem

echo $'\n' > blank.txt

tail -n +3 finalSend.txt > trim.txt
head -n -1 trim.txt > trim2.txt

rm trim.txt
awk '!a[$0]++ {of="f" ++fc".txt"; print $0 >> of ; close(of)}' RS= ORS="\n" trim2.txt

#remove prompt from the last line and place it in the current line
perl -pe 'chomp if eof' f1.txt > f1copy.txt     #contains the encrypted session key
perl -pe 'chomp if eof' f3.txt > f3copy.txt     #contains the signature

rm sender.txt
rm f1.txt
rm f3.txt
rm email.txt
rm certName.txt

#put together pieces to form the content to be signed
#echo '-----BEGIN CSC474 MESSAGE-----' > header.txt
cat f1copy.txt blank.txt f2.txt > toSignCopy.txt

#verify the signature
openssl dgst -sha1 -verify senderPublicKey.pem -signature f3copy.txt toSignCopy.txt > verify.txt

read verify < verify.txt

#var="Verify OK"
#if [ "$verify" == "$var" ]; then
#	echo "Verication Successful"
#else
#	echo "Verification Failed"
#	exit
#fi

#extract session key
openssl rsautl -decrypt -inkey LKPrivate.pem -in f1copy.txt -out sessionKeyDec.txt
read sessionKey < sessionKeyDec.txt

#decrypt the message using the session key
openssl enc -d -aes-256-cbc -a -in f2.txt -out messageDec.txt -pass pass:"$sessionKey"
echo "The message is: "$'\n'
cat messageDec.txt

#rm header.txt
rm blank.txt
rm trim2.txt
rm f1copy.txt
rm f3copy.txt
rm verify.txt
rm toSignCopy.txt
rm f2.txt


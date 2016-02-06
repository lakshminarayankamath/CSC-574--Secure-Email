#!/bin/bash
# Script to Crack DES

# generate all possible key combinations and try decrypting
for ch1 in 'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z';
do
for ch2 in 'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z';
do
for ch3 in 'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z';
do
var=$ch1$ch2$ch3
clear
openssl enc -d -des-cbc -base64 -in outfile.txt -k "$var" > temp.txt
if grep -q [?%#\}\{��$\)\(\\\/*@] temp.txt ; then
echo "Bad"
else 
echo "$var" >> candidateKeys.txt
fi
done;
done;
done

clear
#After this, the left out keys are the candidateKeys. One of the keys should be the actual key

while read name
do
echo "Key Used: "$name $'\n';
echo "Message: "$'\n'
openssl enc -d -des-cbc -base64 -in outfile.txt -k "$name"
done < candidateKeys.txt

rm temp.txt

import urllib
import csv
import sys

arg=sys.argv[1]
user=arg.split('@');
link = "https://courses.ncsu.edu/csc574/lec/001/CertificateRepo"
f1 = urllib.urlopen(link)
cr = dict(filter(None,csv.reader(f1)))

if cr.has_key(user[0]):
    f3 = urllib.urlopen(cr[user[0]])
    print cr[user[0]].rsplit('/',1)[1]
    with open(cr[user[0]].rsplit('/',1)[1],'w') as f4:
	f4.write(f3.read())
else:
    print "Wrong Email ID: Try again "
    exit()

    



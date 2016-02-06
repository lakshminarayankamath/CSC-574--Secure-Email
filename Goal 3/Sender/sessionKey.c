#include<stdio.h>
#include<stdlib.h>

int main()
{
srand(time(0));
int ch[62];
int i=0;
for(i=0;i<26;i++)
  ch[i]=65+i;

int j=0;
for(j=0;j<26;j++)
	ch[i++]=97+j;
int k=0;
for(k=0;k<10;k++)
	ch[i++]=48+k;

for(i=0;i<32;i++)
{
	int rn=rand()%62;
	printf("%c",(char)ch[rn]);
}
printf("\n");
}



%{
#include<stdlib.h>
#include<stdio.h>
%}

digit [0-9]
hex -?0[Xx][0-9a-fA-F]+
letter [_a-zA-Z]
%%
{digit}+ {printf("value=%d\n",atoi(yytext));}
{hex} {int h=strtol(yytexy, NULL, 16);printf("hex=0x%x\n",h);}
%%

int main(int argc,char** argv)
{
    if(argc>1)
    {
        if(!(yyin=fopen(argv[1],"r")))
        {
          
            return 1;
        }

    }
    yylex();
    printf("hello world\n");
    return 0;
}

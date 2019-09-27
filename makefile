# 编译器设定和编译选项
CC = gcc
FLEX = flex
#BISON = bison
 CFLAGS = -std=c99

 # 编译目标：src目录下的所有.c文件
 CFILES = $(shell find ./ -name "*.c")
 OBJS = $(CFILES:.c=.o)
 LFILE = $(shell find ./Compile/ -name "*.l")
# YFILE = $(shell find ./Compile/ -name "*.y")
 LFC = $(shell find ./Compile/ -name "*.l" | sed s/[^/]*\\.l/lex.yy.c/)
# YFC = $(shell find ./Compile/ -name "*.y" | sed s/[^/]*\\.y/syntax.tab.c/)
 LFO = $(LFC:.c=.o)
# YFO = $(YFC:.c=.o)

 scanner: syntax $(filter-out $(LFO),$(OBJS))
 	$(CC) -o parser $(filter-out $(LFO),$(OBJS)) -lfl -ly

 #	syntax: lexical syntax-c
 #		$(CC) -c $(YFC) -o $(YFO)

 		lexical: $(LFILE)
 			$(FLEX) -o $(LFC) $(LFILE)

 #			syntax-c: $(YFILE)
 #				$(BISON) -o $(YFC) -d -v $(YFILE)

 				-include $(patsubst %.o, %.d, $(OBJS))

 				# 定义的一些伪目标
 				.PHONY: clean test
 				test:
 					./scanner ../test.cmm
 					clean:
 						rm -f scanner lex.yy.c
	rm -f $(OBJS) $(OBJS:.o=.d)
	rm -f $(LFC)
        rm -f *~

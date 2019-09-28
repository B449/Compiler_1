# GNU make手册：http://www.gnu.org/software/make/manual/make.html
# ************ 遇到不明白的地方请google以及阅读手册 *************

# 编译器设定和编译选项
CC = gcc
FLEX = flex
BISON = bison
CFLAGS = -std=c99

# 编译目标：src目录下的所有.c文件
CFILES = $(shell find ./ -name "*.c")
OBJS = $(CFILES:.c=.o)
LFILE = $(shell find ./ -name "*.l")
LFC = $(shell find ./ -name "*.l" | sed s/[^/]*\\.l/lex.yy.c/)
LFO = $(LFC:.c=.o)

lexical: $(LFILE)
	$(FLEX) -o $(LFC) $(LFILE)
	$(CC) -o scanner $(LFC) -lfl -ly

-include $(patsubst %.o, %.d, $(OBJS))

# 定义的一些伪目标
.PHONY: clean test
test:
	./scanner test.cmm
clean:
	rm -f scanner lex.yy.c 
	rm -f $(OBJS) $(OBJS:.o=.d)
	rm -f $(LFC)
	rm -f *~

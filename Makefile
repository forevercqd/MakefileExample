#********************************************************************
#	File Name		: Makefile 	    	
#	Author			: Cheng_Qingdong
#	Copyright 1992-2013, ZheJiang Dahua Technology Stock Co.Ltd.
# 						All Rights Reserved
#
#	Description		: for Carlogo recognization
#	Created			: 2014/09/23  14:08
#	Changelog		: (date:author:modify sth)
#
#*********************************************************************

CROSS	= 
# Compilation Tools
CC	= $(CROSS)gcc
CXX	= $(CROSS)g++
LD	= $(CROSS)cc
AR	= $(CROSS)ar
AS	= $(CROSS)as
RM 	= rm -f

ROOT = $(shell pwd)

# Q1 BITS未传进时，默认为32位，传进来时，定义为传进值
BITS	= 32
LDFLAGS	= -lm 
#LDFLAGS	+= -e main #ld来链接时，指定入口函数

ifeq ($(BITS),32)
	CFLAGS 	+= -m32
	CXXFLAGS+= -m32	
	LDFLAGS	+= -m32
	#LDFLAGS	+= -melf_i386 #使用ld链接时指定链接的是32位库:
endif

# 1. 优化级别
ifeq ($(debug), 1)
	CFLAGS += -g3
	CXXFLAGS += -g3
else
	CFLAGS += -O3
	CXXFLAGS += -O3
	
endif

# 2. 宏定义
# .c
CFLAGS +=
CFLAGS +=

# .cpp
CXXFLAGS +=
CXXFLAGS +=

# 3. AR Options
ARFLAGS	= crus

# 4. 输出文件目录
BUILD_DIR = x86_$(BITS)
# 指定源文件、头文件、库路径
# lib_src
vpath %.c 

vpath %.cpp	

# demo_src
vpath %.c  $(ROOT)/src/

# 5. 输出变量
LIB_TARGET	= 
DEMO_TARGET	= demo_test


# 6. 头文件路径
# .c
CFLAGS +=

# .cpp
CXXFLAGS += 

# 7. 库的源文件、obj
LIB_C_SRCS   +=	
LIB_C_OBJS	= $(patsubst %.c,$(BUILD_DIR)/%.o, $(LIB_C_SRCS))

LIB_CXX_SRCS	= 
LIB_CXX_OBJS	= $(patsubst %.cpp,$(BUILD_DIR)/%.o, $(LIB_CXX_SRCS))

# 8. demo的源目录、obj
DEMO_C_SRCS  = swap.c main.c
DEMO_C_OBJS  = $(patsubst %.c, $(BUILD_DIR)/%.o,$(DEMO_C_SRCS))

DEMO_CXX_SRCS	= 
DEMO_CXX_OBJS	= $(patsubst %.cpp,$(BUILD_DIR)/%.o, $(DEMO_CXX_SRCS))

# 9. 默认的输出
all: mkdirectory $(LIB_TARGET) $(DEMO_TARGET)

# 10. 库的生成
$(LIB_TARGET): $(LIB_C_OBJS) $(LIB_CXX_OBJS)
	$(AR)  $(ARFLAGS)   $@	$^

$(LIB_CXX_OBJS): $(BUILD_DIR)/%.o: %.cpp
	$(CXX) -c $(CXXFLAGS)  -o $@ $<

$(LIB_C_OBJS): $(BUILD_DIR)/%.o: %.c
	$(CC) -c $(CFLAGS)  -o $@ $<
	
# 11. demo生成
$(DEMO_TARGET): $(DEMO_C_OBJS) $(DEMO_CXX_SRCS)
	$(LD) $(LDFLAGS)  $^ $(LIB_TARGET) -o $@

$(DEMO_CXX_OBJS): $(BUILD_DIR)/%.o: %.cpp
	$(CXX) -c $(CXXFLAGS)  -o $@ $<

$(DEMO_C_OBJS): $(BUILD_DIR)/%.o: %.c
	$(CC) -c $(CFLAGS)  -o $@ $<
	
# 12. 创建目录
.phony:build

mkdirectory:
	@mkdir -p $(BUILD_DIR)

# 13. 清理
clean:
	$(RM) $(LIB_C_OBJS)  $(LIB_CXX_OBJS) $(DEMO_C_OBJS)  $(DEMO_CXX_OBJS) $(DEMO_TARGET)  $(LIB_TARGET)
	
# 14. 打印消息
print:
	echo $(ROOT)
	echo $(LIB_C_SRCS)
	echo $(LIB_C_OBJS) $(LIB_CXX_OBJS)
	#echo $(CFLAGS)

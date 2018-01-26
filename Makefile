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
LD	= $(CROSS)g++
AR	= $(CROSS)ar
AS	= $(CROSS)as
RM 	= rm -f

ROOT = $(shell pwd)

# 5. 输出变量
LIB_TARGET_1	=add
LIB_TARGET_2	=sub
LIB_TARGET_3	=add_sub
DEMO_TARGET	=demo_test


# Q1 BITS未传进时，默认为32位，传进来时，定义为传进值
BITS	= #32
LDFLAGS	= -L. -l$(LIB_TARGET_3) -l$(LIB_TARGET_2)  -l$(LIB_TARGET_1)
LDFLAGS	+= -e main #ld来链接时，指定入口函数

ifeq ($(BITS),32)
	CFLAGS_COMMON 	+= -m32
	LDFLAGS	+= -m32
	#LDFLAGS	+= -melf_i386 #使用ld链接时指定链接的是32位库:
endif

# 1. 优化级别
ifeq ($(debug), 1)
	CFLAGS_COMMON += -g3
else
	CFLAGS_COMMON += -O3
endif

# 2. 宏定义
# .c
CFLAGS_COMMON +=  -fPIC

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

vpath %.cpp	$(ROOT)/src/

# demo_src
vpath %.c  $(ROOT)/src/


# 6. 头文件路径
# .c
CFLAGS_COMMON += -I./src/
CFLAGS +=

# .cpp
CXXFLAGS += 

# 7. 库的源文件、obj
LIB_1_C_SRCS	+=
LIB_1_CXX_SRCS  +=	add.cpp

LIB_2_C_SRCS	+=
LIB_2_CXX_SRCS  +=	sub.cpp

LIB_3_C_SRCS	+=
LIB_3_CXX_SRCS	+=	add_sub.cpp

# 8. demo的源目录、obj
DEMO_C_SRCS		=  
DEMO_CXX_SRCS	= main.cpp

# 9. 默认的输出
all: mkdirectory dll_1 dll_2 dll_3 exe

# 10. 库的生成
dll_1: $(LIB_1_C_SRCS) $(LIB_1_CXX_SRCS)
	$(CXX) $(CFLAGS_COMMON) $^ -o lib$(LIB_TARGET_1).so -shared

dll_2: $(LIB_2_C_SRCS) $(LIB_2_CXX_SRCS)
	$(CXX) $(CFLAGS_COMMON) $^ -o lib$(LIB_TARGET_2).so -shared

dll_3: $(LIB_3_C_SRCS) $(LIB_3_CXX_SRCS)
	$(CXX) $(CFLAGS_COMMON) $^ -o lib$(LIB_TARGET_3).so -shared -L. -ladd -lsub

# 11. demo生成
exe: $(DEMO_C_SRCS) $(DEMO_CXX_SRCS)
	$(LD) $(CFLAGS_COMMON)   $^  -o $(DEMO_TARGET) $(LDFLAGS) 

# 12. 创建目录
.phony:build

mkdirectory:
	@mkdir -p $(BUILD_DIR)

# 13. 清理
clean:
	$(RM) lib$(LIB_TARGET_1).so lib$(LIB_TARGET_2).so lib$(LIB_TARGET_3).so
	$(RM) $(DEMO_TARGET)
	
# 14. 打印消息
print:
	echo $(ROOT)
	echo $(LIB_C_SRCS)
	echo $(LIB_C_OBJS) $(LIB_CXX_OBJS)
	#echo $(CFLAGS)

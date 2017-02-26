CC      = gcc
LD      = gcc
SIZE    = size

TARGET = luaproj
BINDIR = bin
OBJDIR = obj

HEADERS = lua/lua.h
HEADERS += lua/lapi.h
HEADERS += lua/lctype.h
HEADERS += lua/lfunc.h
HEADERS += lua/llimits.h
HEADERS += lua/lopcodes.h
HEADERS += lua/lstate.h
HEADERS += lua/ltm.h
HEADERS += lua/lundump.h
HEADERS += lua/ldebug.h
HEADERS += lua/lgc.h
HEADERS += lua/lmem.h
HEADERS += lua/lparser.h
HEADERS += lua/lstring.h
HEADERS += lua/lvm.h
HEADERS += lua/lcode.h
HEADERS += lua/ldo.h
HEADERS += lua/llex.h
HEADERS += lua/lobject.h
HEADERS += lua/lprefix.h
HEADERS += lua/ltable.h
HEADERS += lua/luaconf.h
HEADERS += lua/lzio.h

OBJECTS = main.o
OBJECTS += lua/lapi.o
OBJECTS += lua/lstate.o
OBJECTS += lua/ltable.o
OBJECTS += lua/lstring.o
OBJECTS += lua/ltm.o
OBJECTS += lua/lgc.o
OBJECTS += lua/ldo.o
OBJECTS += lua/lvm.o
OBJECTS += lua/lobject.o
OBJECTS += lua/lfunc.o
OBJECTS += lua/lctype.o
OBJECTS += lua/ldebug.o
OBJECTS += lua/lmem.o
OBJECTS += lua/lopcodes.o
OBJECTS += lua/lundump.o
OBJECTS += lua/lzio.o

INCLUDES = lua

COMMON = -Os
COMMON += -Wall
COMMON += -Wextra
COMMON += -flto
COMMON += -ffunction-sections
COMMON += -fdata-sections

CFLAGS = $(COMMON)
CFLAGS += $(addprefix -I, $(INCLUDES))
CFLAGS += -std=c99

LDFLAGS = $(COMMON)
LDFLAGS += -lm

ifeq ($(shell uname -s),Darwin)
    LDFLAGS += -Wl,-dead_strip
else
    LDFLAGS += -Wl,-O1,--gc-sections
endif

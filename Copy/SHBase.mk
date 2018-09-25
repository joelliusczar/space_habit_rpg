CC=gcc
CFLAGS=-Wall -Wextra $(DEBUG)
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))
libfy=lib$(1).so
HEADER_FILES := $(call rwildcard,./,*.h)
SOURCES:= $(call rwildcard,./,*.c)
OBJECTS=$(SOURCES:.c=.o)
OPTIMIZE=-O3
DEBUG?=$(OPTIMIZE)



.c.o:
	$(CC) $(CFLAGS) $(INC) -fPIC -c $< -o $@

clean_g:
	-@find . -type f  \( -name '*.o' -or  -name '*.so' \) -exec rm {} + 2>/dev/null || true


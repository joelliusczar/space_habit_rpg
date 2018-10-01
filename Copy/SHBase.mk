CC=gcc
CFLAGS=-Wall -Wextra $(DEBUG)
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))
libfy=lib$(1).so
stlibfy=lib$(1).a
HEADER_FILES := $(call rwildcard,./,*.h)
SOURCES:= $(call rwildcard,./,*.c)
OBJECTS=$(SOURCES:.c=.o)
OPTIMIZE=-O3
DEBUG?=$(OPTIMIZE)
THIS_OS=$(call detect_os)
detect_os=$(strip $(if $(findstring $(OS),'Windows_NT'),'Windows',$(shell sh -c 'uname -s 2>/dev/null || echo not')))
pickKeywordForOS=$(if $(findstring $(THIS_OS),'Windows'),$(1),$(if $(findstring $(THIS_OS),'Darwin'),$(2),$(if $(findstring $(THIS_OS),'Linux'),$(3),'fuck this shit!')))
PATH_KEYWORD = $(call pickKeywordForOS,'Hell if I know',-install_name,-soname)


.c.o:
	$(CC) $(CFLAGS) $(INC) -fPIC -c $< -o $@

clean_g:
	-@find . -type f  \( -name '*.o' -or  -name '*.so' \) -exec rm {} + 2>/dev/null || true



CC=gcc
CFLAGS=-Wall -Wextra -std=c99 $(DEBUG) $(EXTRA)
#recursive wildcard. pass in directory and pattern
#I think first part gets all matches in current directory
#then within the foreach it is first passed a wildcard
#which expands to all of the directories in current
#directory. So, the foreach loops through the directories
#then does the recursive wildcard on each dir
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))
#libfy generates the dynamic library name
libfy=lib$(1).so
#stlibfy generates the static library name
stlibfy=lib$(1).a
HEADER_FILES := $(call rwildcard,./,*.h)
SOURCES:= $(call rwildcard,./,*.c)
OBJECTS=$(SOURCES:.c=.o)
OPTIMIZE=-O3
DEBUG?=$(OPTIMIZE)
THIS_OS=$(call detect_os)
#strip is trim in other langs
detect_os=$(strip $(if $(findstring $(OS),'Windows_NT'),'Windows',$(shell sh -c 'uname -s 2>/dev/null || echo not')))
pickKeywordForOS=$(if $(findstring $(THIS_OS),'Windows'),$(1),$(if $(findstring $(THIS_OS),'Darwin'),$(2),$(if $(findstring $(THIS_OS),'Linux'),$(3),'fuck this shit!')))
#if the os is mac then keyword is install_name, if linux, then it's soname. Haven't bothered
#to figure out what it is for windows
PATH_KEYWORD = $(call pickKeywordForOS,'Hell if I know',-install_name,-soname)


.c.o:
	$(CC) $(CFLAGS) $(INC) -fPIC -c $< -o $@

clean_g:
	-@find . -type f  \( -name '*.o' -or  -name '*.so' \) -exec rm {} + 2>/dev/null || true



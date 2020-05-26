CC=gcc
CFLAGS=-Wall -Wextra $(DEBUG)
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))
INC=-I../SHDatetime -I../SHUtils_C
HEADER_FILES := $(call rwildcard,./,*.h)
#make does not seem to mind the tab below for SOURCES.
#Some cases, it can be very finiky about spacing
SOURCES:= $(call rwildcard,./,*.c) $(call rwildcard,../SHUtils_C,*.c)\
	 $(call rwildcard,../SHDatetime,*.c)
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE=dt_prompt
DT_SHARED=dt
DT_SHARED_FULL=lib${DT_SHARED}.so
OPTIMIZE=-O3
DEBUG?=$(OPTIMIZE)


all: $(HEADER_FILES) $(SOURCES) $(EXECUTABLE) COPY

$(EXECUTABLE): $(DT_SHARED_FULL) SHCLDtPrompt.c
	$(CC) $(INC) $(CFLAGS) -L. -l$(DT_SHARED) SHCLDtPrompt.c -o $@

#copy executable to where it is included in path
COPY: $(DT_SHARED_FULL) $(EXECUTABLE)
	@if [ ${DEBUG} = ${OPTIMIZE} ]; then\
		cp $(EXECUTABLE) $(DT_SHARED_FULL) ~/bin;\
	fi

COPY_CODE:
	-@cp *c *h *py Makefile ../copy_up

$(DT_SHARED_FULL): $(OBJECTS)
	$(CC) $(INC) $(CFLAGS) $(OBJECTS) -shared -o $(DT_SHARED_FULL)

.c.o:
	$(CC) $(CFLAGS) $(INC) -fPIC -c $< -o $@

clean:
	-@find . -type f -name '*.o' -exec rm {} + 2>/dev/null || true
	-@rm *.o dt_prompt *.so 2>/dev/null || true


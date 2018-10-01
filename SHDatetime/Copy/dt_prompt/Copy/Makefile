CC=gcc
CFLAGS=-Wall -Wextra $(DEBUG)
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))
INC=-ISHGlobal_C -ISHDatetime -ISH_CTools
HEADER_FILES := $(call rwildcard,./,*.h)
SOURCES:= $(call rwildcard,./,*.c)
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE=dt_prompt
DT_SHARED=dt
DT_SHARED_FULL=lib${DT_SHARED}.so
OPTIMIZE=-O3
DEBUG?=$(OPTIMIZE)


all: $(HEADER_FILES) $(SOURCES) $(EXECUTABLE) COPY

$(EXECUTABLE): $(DT_SHARED_FULL) dt_prompt.c
	$(CC) $(INC) $(CFLAGS) -L. -l$(DT_SHARED) dt_prompt.c -o $@

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


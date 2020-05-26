SH_UTILS_C_PATH = ./SHUtils_C/
SHDATETIME_PATH = ./SHDatetime/
SHSPECIAL_C_PATH = ./SHSpecial_C/
include SHBase.mk
include $(SH_UTILS_C_PATH)vars.mk
include $(SHDATETIME_PATH)vars.mk
include $(SHSPECIAL_C_PATH)vars.mk
SH_UTILS_C_FULL:= $(SH_UTILS_C_PATH)$(call libfy,$(SH_UTILS_C))
DT_SHARED_FULL:= $(SHDATETIME_PATH)$(call libfy,$(DT_SHARED))
SH_TOP_FULL:=$(SHSPECIAL_C_PATH)$(call libfy,$(SH_TOP))
INC = -I$(SHDATETIME_PATH) -I$(SH_UTILS_C_PATH) -I$(SHSPECIAL_C_PATH)
SIMPLE_DT = dt
SIMPLE_DT_FULL = $(call libfy,$(SIMPLE_DT))
SIMPLE_DT_PATH = ./
EXECUTABLE = dt_prompt
SH_UTILS_C_HEADERS = $(call rwildcard,$(SH_UTILS_C_PATH),*.h)
SH_UTILS_C_SOURCES = $(call rwildcard,$(SH_UTILS_C_PATH),*.c)
SH_UTILS_C_OBJECTS=$(SH_UTILS_C_SOURCES:.c=.o)
SHDATETIME_HEADERS = $(call rwildcard,$(SHDATETIME_PATH),*.h)
SHDATETIME_SOURCES = $(call rwildcard,$(SHDATETIME_PATH),*.c)
SHDATETIME_OBJECTS = $(SHDATETIME_SOURCES:.c=.o)
SH_C_HEADERS = $(call rwildcard,$(SHSPECIAL_C_PATH),*.h)
SH_C_SOURCES = $(call rwildcard,$(SHSPECIAL_C_PATH),*.c)
SH_C_OBJECTS = $(SH_C_SOURCES:.c=.o)
HEADER_FILES = $(SH_UTILS_C_HEADERS) $(SH_C_HEADERS) $(SH_C_HEADERS)
SOURCES = $(SH_UTILS_C_SOURCES) $(SH_C_SOURCES) $(SH_C_SOURCES)
.DEFAULT_GOAL:=all


all: $(HEADER_FILES) $(SOURCES) $(DT_SHARED_FULL) $(SH_UTILS_C_FULL) $(SH_TOP_FULL)
	@echo "dtShared $DT_SHARED_FULL"


$(EXECUTABLE): $(SIMPLE_DT_FULL) dt_prompt.c
	$(CC) $(INC) $(CFLAGS) -L$(SIMPLE_DT_PATH) -Wl,-rpath,$(SIMPLE_DT_PATH) \
	-l$(SIMPLE_DT) dt_prompt.c -o $@

COPY: $(SIMPLE_DT_FULL) $(EXECUTABLE)
	@if [ ${DEBUG} = ${OPTIMIZE} ]; then\
		cp $(EXECUTABLE) $(SIMPLE_DT_FULL) ~/bin;\
	fi

COPY_CODE:
	-@cp *c *h *py Makefile ../copy_up

$(SIMPLE_DT_FULL): $(SHDATETIME_OBJECTS) $(SH_UTILS_C_OBJECTS)
	$(CC) $(INC) $(CFLAGS) $(SHDATETIME_OBJECTS) $(SH_UTILS_C_OBJECTS) \
	-shared -o $(SIMPLE_DT_FULL)

$(DT_SHARED_FULL): $(SHDATETIME_OBJECTS) $(SH_UTILS_C_FULL)
	@echo 'build SHDatetime'
	cd $(SHDATETIME_PATH) && $(MAKE)

$(SH_UTILS_C_FULL): $(SH_UTILS_C_OBJECTS)
	@echo 'build SHUtils_C'
	cd $(SH_UTILS_C_PATH) && $(MAKE)

$(SH_TOP_FULL): $(SH_C_OBJECTS) $(DT_SHARED_FULL) $(SH_UTILS_C_FULL)
	@echo 'build SH_C'
	cd $(SHSPECIAL_C_PATH) && $(MAKE)


clean: clean_g
	-@rm *.o dt_prompt *.so 2>/dev/null || true


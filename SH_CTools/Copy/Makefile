include ../SHBase.mk
include vars.mk
SOURCE?=''
SH_TOOLS_FULL=$(call libfy,$(SH_TOOLS)$(SOURCE))
.DEFAULT_GOAL:=$(SH_TOOLS_FULL)
PARENT_PATH ?= .

$(SH_TOOLS_FULL): $(OBJECTS)
	@echo $(PARENT_PATH)
	$(CC) $(INC) $(CFLAGS) $(OBJECTS) -Wl,$(PATH_KEYWORD),$(PARENT_PATH)$(SH_TOOLS_FULL) -shared -o $(SH_TOOLS_FULL)



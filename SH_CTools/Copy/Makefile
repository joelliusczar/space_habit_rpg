include ../SHBase.mk
include vars.mk
SH_TOOLS_FULL=$(call libfy,$(SH_TOOLS))
.DEFAULT_GOAL:=$(SH_TOOLS_FULL)

$(SH_TOOLS_FULL): $(OBJECTS)
	$(CC) $(INC) $(CFLAGS) $(OBJECTS) -shared -o $(SH_TOOLS_FULL)

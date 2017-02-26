include config.mk

OBJLIST = $(addprefix $(OBJDIR)/, $(OBJECTS))
TARGETLIST = $(BINDIR)/$(TARGET)

all: $(TARGETLIST)
	$(SIZE) $(BINDIR)/$(TARGET)

clean:
	rm -rf $(BINDIR) $(OBJDIR)

$(BINDIR)/$(TARGET): $(OBJLIST)
	mkdir -p $(dir $@)
	$(LD) $(LDFLAGS) -o $@ $^

$(OBJDIR)/%.o: %.c $(HEADERS)
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $<
#	$(CC) $(CFLAGS) -E $< > $@.i

$(OBJDIR)/%.o: %.s $(HEADERS)
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $<

.PHONY: all clean

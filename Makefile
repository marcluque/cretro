# project name (generate executable with this name)
TARGET	= ch8

CC	= gcc
# compiling flags here
CFLAGS   = -g -std=c17 -Wall -Wextra -Werror

LINKER	= gcc
# linking flags here
LFLAGS	= -Wall -lm -lSDL2

# change these to proper directories where each file should be
SRCDIR	= src
OBJDIR	= obj
BINDIR	= .

SOURCES		:= $(wildcard $(SRCDIR)/*.c)
INCLUDES	:= $(wildcard $(SRCDIR)/*.h)
OBJECTS		:= $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
rm			:= rm -f
mkdir       := mkdir -p

$(BINDIR)/$(TARGET): $(OBJECTS)
	@$(LINKER) $(OBJECTS) $(LFLAGS) -o $@
	@echo "Linking complete!"

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.c | $(BINDIR) $(OBJDIR) 
	@$(CC) $(CFLAGS) -c $< -o $@
	@echo "Compiled "$<" successfully!"

$(BINDIR) $(OBJDIR):
	@$(mkdir) $@

.PHONY: clean
clean:
	@$(rm) -r $(OBJDIR)
	@$(rm) $(TARGET)
	@echo "Cleanup complete!"

.PHONY: remove
remove: clean
	@$(rm) $(BINDIR)/$(TARGET)
	@echo "Executable removed!"

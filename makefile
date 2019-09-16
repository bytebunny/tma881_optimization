CC=gcc
CFLAGS = -O2 -Wall
LIBS=-larb -lflint -lmpfr -lgmp -lpthread
# Directory to keep object files:
ODIR=obj

_OBJ = time_sum.o mainfile.o

OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

# Rule to generate object files:
$(ODIR)/%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

.PHONY: all
all: time_sum mainfile

time_sum: $(ODIR)/time_sum.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

mainfile: $(ODIR)/mainfile.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

.PHONY: clean # Avoid conflict with a file of the same name
clean:
	rm -f $(ODIR)/*.o time_sum mainfile

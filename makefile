CC=gcc
CFLAGS = -O2 -Wall -march=native
LIBS = -larb -lflint -lmpfr -lgmp -lpthread
# Directory to keep object files:
ODIR = obj
IDIR = include

# _OBJ = time_sum.o mainfile.o
# OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

_DEPS = mul_cpx_separatefile.h
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

.PHONY: all
all: time_sum mainfile separatefile inlined locality \
	indirect_addressing_1 indirect_addressing_2 \
	indirect_addressing_alt write_hdd write_ssd

# Rule to generate object files:
# $(ODIR)/%.o: %.c $(DEPS)
# 	$(CC) -c -o $@ $< $(CFLAGS) -I$(IDIR)
$(ODIR)/time_sum.o: time_sum.c 
	$(CC) -c -o $@ $< $(CFLAGS)

## Inlining
$(ODIR)/mainfile.o: mainfile.c 
	$(CC) -c -o $@ $< $(CFLAGS)

$(ODIR)/inlined.o: inlined.c 
	$(CC) -c -o $@ $< $(CFLAGS)

$(ODIR)/mul_cpx_separatefile.o: mul_cpx_separatefile.c
	$(CC) -flto -c -o $@ $< $(CFLAGS)

$(ODIR)/separatefile.o: separatefile.c $(DEPS)
	$(CC) -flto -c -o $@ $< $(CFLAGS) -I$(IDIR)

## Locality
$(ODIR)/locality.o: locality.c 
	$(CC) -c -o $@ $< $(CFLAGS)

## Indirect addressing
$(ODIR)/indirect_addressing_1.o: indirect_addressing_1.c 
	$(CC) -c -o $@ $< $(CFLAGS)

$(ODIR)/indirect_addressing_2.o: indirect_addressing_2.c 
	$(CC) -c -o $@ $< $(CFLAGS)

$(ODIR)/indirect_addressing_alt.o: indirect_addressing_alt.c 
	$(CC) -c -o $@ $< $(CFLAGS)

## Writing to HDD and SSD
$(ODIR)/write_hdd.o: write_hdd.c 
	$(CC) -c -o $@ $< $(CFLAGS)

$(ODIR)/write_ssd.o: write_ssd.c 
	$(CC) -c -o $@ $< $(CFLAGS)


time_sum: $(ODIR)/time_sum.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

## Inlining
mainfile: $(ODIR)/mainfile.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

inlined: $(ODIR)/inlined.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

separatefile: $(ODIR)/separatefile.o $(ODIR)/mul_cpx_separatefile.o $(DEPS)
	$(CC) -flto -o $@ $^ $(CFLAGS) $(LIBS)

## Locality
locality: $(ODIR)/locality.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

## Indirect addressing:
indirect_addressing_1: $(ODIR)/indirect_addressing_1.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

indirect_addressing_2: $(ODIR)/indirect_addressing_2.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

indirect_addressing_alt: $(ODIR)/indirect_addressing_alt.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

## Writing to HDD and SSD
write_hdd: $(ODIR)/write_hdd.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

write_ssd: $(ODIR)/write_ssd.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)


.PHONY: clean # Avoid conflict with a file of the same name
clean:
	rm -f $(ODIR)/*.o time_sum mainfile separatefile inlined \
		  locality indirect_addressing_1 indirect_addressing_2 \
		  indirect_addressing_alt write_hdd write_ssd $(IDIR)/*~

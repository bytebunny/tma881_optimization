CC=gcc
CFLAGS = -O0 -Wall -march=native
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
	indirect_addressing_alt write_hdd write_ssd \
	valgrind_test valgrind_test_no_init \
	valgrind_test_no_free valgrind_test_double_free \
	invalid_access

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

## Valgrind
$(ODIR)/valgrind_test.o: valgrind_test.c 
	$(CC) -c -o $@ $< -g $(CFLAGS)

$(ODIR)/valgrind_test_no_init.o: valgrind_test_no_init.c 
	$(CC) -c -o $@ $< -g $(CFLAGS)

$(ODIR)/valgrind_test_no_free.o: valgrind_test_no_free.c 
	$(CC) -c -o $@ $< -g $(CFLAGS)

$(ODIR)/valgrind_test_double_free.o: valgrind_test_double_free.c 
	$(CC) -c -o $@ $< -g $(CFLAGS)

## GDB
$(ODIR)/invalid_access.o: invalid_access.c 
	$(CC) -c -o $@ $< -g $(CFLAGS)



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

## Valgrind
valgrind_test: $(ODIR)/valgrind_test.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

valgrind_test_no_init: $(ODIR)/valgrind_test_no_init.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

valgrind_test_no_free: $(ODIR)/valgrind_test_no_free.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

valgrind_test_double_free: $(ODIR)/valgrind_test_double_free.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

## GDB
invalid_access: $(ODIR)/invalid_access.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)


.PHONY: clean # Avoid conflict with a file of the same name
clean:
	rm -f $(ODIR)/*.o time_sum mainfile separatefile inlined \
		  locality indirect_addressing_1 indirect_addressing_2 \
		  indirect_addressing_alt write_hdd write_ssd \
		  valgrind_test valgrind_test_no_init \
		  valgrind_test_no_free valgrind_test_double_free \
		  invalid_access $(IDIR)/*~

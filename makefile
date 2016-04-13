#
# makefile
# This file is part of tripforce.
# See tripforce.c for copyright or LICENSE for license information.
#
     
CC=gcc
CFLAGS=-O3 -ansi -march=native
LDFLAGS=-lcrypto -fopenmp
INSTALLDIR=/usr/local/bin
OUTPUT=tripforce
INPUT=$(wildcard *.c)

# OS X compatibility
OS_STR=$(shell uname -s)
ifeq ($(OS_STR), Darwin)
CC=clang-omp
LDFLAGS=-lcrypto -lssl -fopenmp -L/usr/local/opt/openssl/lib -I/usr/local/opt/openssl/include
endif

.PHONY: all install uninstall remove clean profile

all: $(INPUT)
	$(CC) $(CFLAGS) -o $(OUTPUT) $(INPUT) $(LDFLAGS)

install: all
	mv $(OUTPUT) $(INSTALLDIR)

uninstall:
	rm -rf $(INSTALLDIR)/$(OUTPUT)

remove: uninstall

clean:
	rm -rf $(OUTPUT) $(wildcard *.out)

profile: clean
	$(CC) -pg $(INPUT) $(LDFLAGS)

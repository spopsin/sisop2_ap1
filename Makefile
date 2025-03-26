CC = gcc
CFLAGS = -fPIC -Wall
LDFLAGS = -shared

all: liblock.so programa

liblock.so: lamport_lock.o
	$(CC) $(LDFLAGS) -o liblock.so lamport_lock.o

lamport_lock.o: lamport_lock.c
	$(CC) $(CFLAGS) -c lamport_lock.c

programa: main.c
	$(CC) -o programa main.c -L . -llock -lpthread

clean:
	rm -f *.o *.so programa
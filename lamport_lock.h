#ifndef LAMPORT_LOCK_H
#define LAMPORT_LOCK_H

#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define N 3 // Número de threads

volatile int choosing[N];  
volatile int ticket[N];    

void lamport_mutex_init();
void lamport_mutex_lock(int thread_id);
void lamport_mutex_unlock(int thread_id);

#endif
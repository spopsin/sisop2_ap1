#include "lamport_lock.h"

int max_ticket() {
    int max = 0;
    for (int i = 0; i < N; i++) {
        if (ticket[i] > max) {
            max = ticket[i];
        }
    }
    return max;
}

void lamport_mutex_init() {
    for (int i = 0; i < N; i++) {
        choosing[i] = 0;
        ticket[i] = 0;
    }
}

void lamport_mutex_lock(int thread_id) {
    choosing[thread_id] = 1;
    ticket[thread_id] = max_ticket() + 1;
    choosing[thread_id] = 0;

    for (int j = 0; j < N; j++) {
        while (choosing[j]);  // Aguarde enquanto outra thread escolhe um ticket
        
        while (ticket[j] != 0 && 
              (ticket[j] < ticket[thread_id] || 
              (ticket[j] == ticket[thread_id] && j < thread_id))) {
            // Aguarde se outra thread tem prioridade
        }
    }
}

void lamport_mutex_unlock(int thread_id) {
    ticket[thread_id] = 0;  // Libera a seção crítica
}

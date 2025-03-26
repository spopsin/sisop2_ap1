#include "lamport_lock.h"

void *thread_process(void *arg) {
    int thread_id = *((int *) arg);
    
    printf("Hello! I'm thread %d!\n", thread_id);

    while (1) {
        lamport_mutex_lock(thread_id);

        // Seção crítica
        printf("I'm thread %d and I'm entering my critical region!\n", thread_id);
        dormir();
        printf("I'm thread %d and I'm leaving my critical region!\n", thread_id);

        lamport_mutex_unlock(thread_id);
    }

    return NULL;
}

int main() {
    pthread_t threads[N];
    int thread_ids[N];

    lamport_mutex_init();

    for (int i = 0; i < N; i++) {
        thread_ids[i] = i;
        pthread_create(&threads[i], NULL, thread_process, &thread_ids[i]);
    }

    for (int i = 0; i < N; i++) {
        pthread_join(threads[i], NULL);
    }

    return 0;
}

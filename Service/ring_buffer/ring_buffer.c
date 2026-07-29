/*
 * ring_buffer.c
 * Circular Buffer Implementation
 */

#include "ring_buffer.h"
#include <string.h>

/* ==================== Functions Implementation ==================== */

void RingBuffer_Init(RingBuffer_t* rb, uint8_t* buffer, uint16_t size) {
    if (rb == NULL || buffer == NULL || size == 0) {
        return;
    }
    rb->buffer = buffer;
    rb->size = size;
    rb->head = 0;
    rb->tail = 0;
    rb->count = 0;
    memset(buffer, 0, size);
}

uint8_t RingBuffer_Push(RingBuffer_t* rb, uint8_t data) {
    if (rb == NULL || RingBuffer_IsFull(rb)) {
        return FALSE;
    }
    
    rb->buffer[rb->head] = data;
    rb->head = (rb->head + 1) % rb->size;
    rb->count++;
    return TRUE;
}

uint8_t RingBuffer_Pop(RingBuffer_t* rb, uint8_t* data) {
    if (rb == NULL || data == NULL || RingBuffer_IsEmpty(rb)) {
        return FALSE;
    }
    
    *data = rb->buffer[rb->tail];
    rb->tail = (rb->tail + 1) % rb->size;
    rb->count--;
    return TRUE;
}

uint8_t RingBuffer_IsEmpty(const RingBuffer_t* rb) {
    if (rb == NULL) {
        return TRUE;
    }
    return (rb->count == 0);
}

uint8_t RingBuffer_IsFull(const RingBuffer_t* rb) {
    if (rb == NULL) {
        return TRUE;
    }
    return (rb->count == rb->size);
}

uint16_t RingBuffer_GetCount(const RingBuffer_t* rb) {
    if (rb == NULL) {
        return 0;
    }
    return rb->count;
}

void RingBuffer_Clear(RingBuffer_t* rb) {
    if (rb == NULL) {
        return;
    }
    rb->head = 0;
    rb->tail = 0;
    rb->count = 0;
    memset(rb->buffer, 0, rb->size);
}

uint8_t RingBuffer_Peek(const RingBuffer_t* rb, uint8_t* data) {
    if (rb == NULL || data == NULL || RingBuffer_IsEmpty(rb)) {
        return FALSE;
    }
    
    *data = rb->buffer[rb->tail];
    return TRUE;
}
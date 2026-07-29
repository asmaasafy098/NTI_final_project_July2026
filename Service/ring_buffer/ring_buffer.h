/*
 * ring_buffer.h
 * Circular Buffer Implementation
 */

#ifndef RING_BUFFER_H
#define RING_BUFFER_H

#include "STD_Types.h"

/* ==================== Data Types ==================== */
typedef struct {
    uint8_t* buffer;      /* Pointer to buffer memory */
    uint16_t head;        /* Write index */
    uint16_t tail;        /* Read index */
    uint16_t size;        /* Buffer size in bytes */
    uint16_t count;       /* Number of bytes stored */
} RingBuffer_t;

/* ==================== Functions ==================== */

/**
 * @brief Initialize ring buffer
 * @param rb Pointer to ring buffer structure
 * @param buffer Pointer to buffer memory
 * @param size Size of buffer in bytes
 */
void RingBuffer_Init(RingBuffer_t* rb, uint8_t* buffer, uint16_t size);

/**
 * @brief Push byte to ring buffer
 * @param rb Pointer to ring buffer structure
 * @param data Byte to push
 * @return TRUE if successful, FALSE if buffer full
 */
uint8_t RingBuffer_Push(RingBuffer_t* rb, uint8_t data);

/**
 * @brief Pop byte from ring buffer
 * @param rb Pointer to ring buffer structure
 * @param data Pointer to store popped byte
 * @return TRUE if successful, FALSE if buffer empty
 */
uint8_t RingBuffer_Pop(RingBuffer_t* rb, uint8_t* data);

/**
 * @brief Check if ring buffer is empty
 * @param rb Pointer to ring buffer structure
 * @return TRUE if empty, FALSE otherwise
 */
uint8_t RingBuffer_IsEmpty(const RingBuffer_t* rb);

/**
 * @brief Check if ring buffer is full
 * @param rb Pointer to ring buffer structure
 * @return TRUE if full, FALSE otherwise
 */
uint8_t RingBuffer_IsFull(const RingBuffer_t* rb);

/**
 * @brief Get number of bytes in ring buffer
 * @param rb Pointer to ring buffer structure
 * @return Number of bytes in buffer
 */
uint16_t RingBuffer_GetCount(const RingBuffer_t* rb);

/**
 * @brief Clear ring buffer
 * @param rb Pointer to ring buffer structure
 */
void RingBuffer_Clear(RingBuffer_t* rb);

/**
 * @brief Peek at byte without removing it
 * @param rb Pointer to ring buffer structure
 * @param data Pointer to store peeked byte
 * @return TRUE if successful, FALSE if empty
 */
uint8_t RingBuffer_Peek(const RingBuffer_t* rb, uint8_t* data);

#endif /* RING_BUFFER_H */
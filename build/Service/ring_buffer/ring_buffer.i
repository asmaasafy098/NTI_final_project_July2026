# 1 "Service/ring_buffer/ring_buffer.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "Service/ring_buffer/ring_buffer.c"





# 1 "Service/ring_buffer/ring_buffer.h" 1
# 9 "Service/ring_buffer/ring_buffer.h"
# 1 "Service/STD_Types.h" 1



# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 1 3 4
# 9 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 3 4
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 1 3 4
# 125 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4

# 125 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 10 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 2 3 4
# 5 "Service/STD_Types.h" 2



# 7 "Service/STD_Types.h"
typedef int8_t sint8_t;
typedef int16_t sint16_t;
typedef int32_t sint32_t;
typedef int64_t sint64_t;

typedef sint8_t sint8;
typedef sint16_t sint16;
typedef sint32_t sint32;
typedef sint64_t sint64;

typedef int8_t s8;
typedef int16_t s16;
typedef int32_t s32;
typedef int64_t s64;


typedef uint8_t uint8;
typedef uint16_t uint16;
typedef uint32_t uint32;
typedef uint64_t uint64;


typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;


typedef float float32_t;
typedef double float64_t;
typedef float f32;
typedef double f64;


typedef enum {
    FALSE = 0,
    TRUE = 1
} bool_t;
# 55 "Service/STD_Types.h"
typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

typedef Std_ReturnType STD_ReturnType;
# 10 "Service/ring_buffer/ring_buffer.h" 2


typedef struct {
    uint8_t* buffer;
    uint16_t head;
    uint16_t tail;
    uint16_t size;
    uint16_t count;
} RingBuffer_t;
# 28 "Service/ring_buffer/ring_buffer.h"
void RingBuffer_Init(RingBuffer_t* rb, uint8_t* buffer, uint16_t size);







uint8_t RingBuffer_Push(RingBuffer_t* rb, uint8_t data);







uint8_t RingBuffer_Pop(RingBuffer_t* rb, uint8_t* data);






uint8_t RingBuffer_IsEmpty(const RingBuffer_t* rb);






uint8_t RingBuffer_IsFull(const RingBuffer_t* rb);






uint16_t RingBuffer_GetCount(const RingBuffer_t* rb);





void RingBuffer_Clear(RingBuffer_t* rb);







uint8_t RingBuffer_Peek(const RingBuffer_t* rb, uint8_t* data);
# 7 "Service/ring_buffer/ring_buffer.c" 2
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 1 3
# 46 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stddef.h" 1 3 4
# 216 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stddef.h" 3 4

# 216 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stddef.h" 3 4
typedef unsigned int size_t;
# 47 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 2 3
# 125 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern int ffs(int __val) __attribute__((__const__));





extern int ffsl(long __val) __attribute__((__const__));





__extension__ extern int ffsll(long long __val) __attribute__((__const__));
# 150 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern void *memccpy(void *, const void *, int, size_t);
# 162 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern void *memchr(const void *, int, size_t) __attribute__((__pure__));
# 180 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern int memcmp(const void *, const void *, size_t) __attribute__((__pure__));
# 191 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern void *memcpy(void *, const void *, size_t);
# 203 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern void *memmem(const void *, size_t, const void *, size_t) __attribute__((__pure__));
# 213 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern void *memmove(void *, const void *, size_t);
# 225 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern void *memrchr(const void *, int, size_t) __attribute__((__pure__));
# 235 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern void *memset(void *, int, size_t);
# 248 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strcat(char *, const char *);
# 262 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strchr(const char *, int) __attribute__((__pure__));
# 274 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strchrnul(const char *, int) __attribute__((__pure__));
# 287 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern int strcmp(const char *, const char *) __attribute__((__pure__));
# 305 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strcpy(char *, const char *);
# 320 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern int strcasecmp(const char *, const char *) __attribute__((__pure__));
# 333 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strcasestr(const char *, const char *) __attribute__((__pure__));
# 344 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern size_t strcspn(const char *__s, const char *__reject) __attribute__((__pure__));
# 364 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strdup(const char *s1);
# 377 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern size_t strlcat(char *, const char *, size_t);
# 388 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern size_t strlcpy(char *, const char *, size_t);
# 399 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern size_t strlen(const char *) __attribute__((__pure__));
# 411 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strlwr(char *);
# 422 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strncat(char *, const char *, size_t);
# 434 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern int strncmp(const char *, const char *, size_t) __attribute__((__pure__));
# 449 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strncpy(char *, const char *, size_t);
# 464 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern int strncasecmp(const char *, const char *, size_t) __attribute__((__pure__));
# 478 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern size_t strnlen(const char *, size_t) __attribute__((__pure__));
# 491 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strpbrk(const char *__s, const char *__accept) __attribute__((__pure__));
# 505 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strrchr(const char *, int) __attribute__((__pure__));
# 515 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strrev(char *);
# 533 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strsep(char **, const char *);
# 544 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern size_t strspn(const char *__s, const char *__accept) __attribute__((__pure__));
# 557 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strstr(const char *, const char *) __attribute__((__pure__));
# 576 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strtok(char *, const char *);
# 593 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strtok_r(char *, const char *, char **);
# 606 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strupr(char *);



extern int strcoll(const char *s1, const char *s2);
extern char *strerror(int errnum);
extern size_t strxfrm(char *dest, const char *src, size_t n);
# 8 "Service/ring_buffer/ring_buffer.c" 2




# 11 "Service/ring_buffer/ring_buffer.c"
void RingBuffer_Init(RingBuffer_t* rb, uint8_t* buffer, uint16_t size) {
    if (rb == 
# 12 "Service/ring_buffer/ring_buffer.c" 3 4
             ((void *)0) 
# 12 "Service/ring_buffer/ring_buffer.c"
                  || buffer == 
# 12 "Service/ring_buffer/ring_buffer.c" 3 4
                               ((void *)0) 
# 12 "Service/ring_buffer/ring_buffer.c"
                                    || size == 0) {
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
    if (rb == 
# 24 "Service/ring_buffer/ring_buffer.c" 3 4
             ((void *)0) 
# 24 "Service/ring_buffer/ring_buffer.c"
                  || RingBuffer_IsFull(rb)) {
        return 0;
    }

    rb->buffer[rb->head] = data;
    rb->head = (rb->head + 1) % rb->size;
    rb->count++;
    return 1;
}

uint8_t RingBuffer_Pop(RingBuffer_t* rb, uint8_t* data) {
    if (rb == 
# 35 "Service/ring_buffer/ring_buffer.c" 3 4
             ((void *)0) 
# 35 "Service/ring_buffer/ring_buffer.c"
                  || data == 
# 35 "Service/ring_buffer/ring_buffer.c" 3 4
                             ((void *)0) 
# 35 "Service/ring_buffer/ring_buffer.c"
                                  || RingBuffer_IsEmpty(rb)) {
        return 0;
    }

    *data = rb->buffer[rb->tail];
    rb->tail = (rb->tail + 1) % rb->size;
    rb->count--;
    return 1;
}

uint8_t RingBuffer_IsEmpty(const RingBuffer_t* rb) {
    if (rb == 
# 46 "Service/ring_buffer/ring_buffer.c" 3 4
             ((void *)0)
# 46 "Service/ring_buffer/ring_buffer.c"
                 ) {
        return 1;
    }
    return (rb->count == 0);
}

uint8_t RingBuffer_IsFull(const RingBuffer_t* rb) {
    if (rb == 
# 53 "Service/ring_buffer/ring_buffer.c" 3 4
             ((void *)0)
# 53 "Service/ring_buffer/ring_buffer.c"
                 ) {
        return 1;
    }
    return (rb->count == rb->size);
}

uint16_t RingBuffer_GetCount(const RingBuffer_t* rb) {
    if (rb == 
# 60 "Service/ring_buffer/ring_buffer.c" 3 4
             ((void *)0)
# 60 "Service/ring_buffer/ring_buffer.c"
                 ) {
        return 0;
    }
    return rb->count;
}

void RingBuffer_Clear(RingBuffer_t* rb) {
    if (rb == 
# 67 "Service/ring_buffer/ring_buffer.c" 3 4
             ((void *)0)
# 67 "Service/ring_buffer/ring_buffer.c"
                 ) {
        return;
    }
    rb->head = 0;
    rb->tail = 0;
    rb->count = 0;
    memset(rb->buffer, 0, rb->size);
}

uint8_t RingBuffer_Peek(const RingBuffer_t* rb, uint8_t* data) {
    if (rb == 
# 77 "Service/ring_buffer/ring_buffer.c" 3 4
             ((void *)0) 
# 77 "Service/ring_buffer/ring_buffer.c"
                  || data == 
# 77 "Service/ring_buffer/ring_buffer.c" 3 4
                             ((void *)0) 
# 77 "Service/ring_buffer/ring_buffer.c"
                                  || RingBuffer_IsEmpty(rb)) {
        return 0;
    }

    *data = rb->buffer[rb->tail];
    return 1;
}

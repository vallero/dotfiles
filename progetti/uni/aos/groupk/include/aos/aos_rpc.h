/**
 * \file
 * \brief Interface declaration for AOS rpc-like messaging
 */

/*
 * Copyright (c) 2013, ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */
#ifndef _LIB_BARRELFISH_AOS_MESSAGES_H
#define _LIB_BARRELFISH_AOS_MESSAGES_H

#include <aos/aos.h>
#include <aos/lmp_chan.h>

struct aos_rpc;

#define READTERM_BUFSIZE 1024

/**
 * Utils
 */

struct capref aos_rpc_local_cap(struct aos_rpc *chan);

void _aos_rpc_initialize_init(void);
void _aos_rpc_set_main_cb(void);
errval_t _aos_rpc_set_closure(struct aos_rpc*, struct event_closure);
struct aos_rpc* _aos_rpc_chan_alloc(void);
void _aos_rpc_set_chan(struct aos_rpc*, struct lmp_chan);

/**
 * Protocol
 */
#pragma pack(push, 1)
#define RPC_MAX_LEN (LMP_MSG_LENGTH*4)
#define RPC_RESERVED    2
typedef union rpc_req_union {
    struct {
        uint8_t type;
        uint8_t longreq;
        union {
            uint16_t len;
            char buf[1];
        };
    };
    char bytes[RPC_MAX_LEN];
} rpc_req;

typedef union rpc_res_union {
    struct {
        errval_t err;
        uint8_t res_type;
    } args;
    char bytes[RPC_MAX_LEN];
} rpc_res;

#define RPC_RAM_CAP_REQ 1
#define RPC_PUTCHAR_REQ 2
#define RPC_GETCHAR_REQ 3
#define RPC_PUTS_REQ 4
#define RPC_READ_REQ 5
#define RPC_REQ_PROC_SPAWN 6
#define RPC_REG_SERVICE 7
#define RPC_BIND_FRAME 8
#define RPC_REMOTE_BIND_FRAME 9
#define RPC_DEV_CAP_REQ 10
#define RPC_IRQ_CAP_REQ 11
#define RPC_REMOTE_RES 12
#define RPC_RUN_TEST 13

// The following types make sense only if the 
// response is received over URPC

/* RAMCAP */
// Request
typedef struct rpc_req_ram_cap_ {
    size_t size;
    size_t align;
} rpc_req_ram_cap;

// Response
// typedef union rpc_res_ram_cap_ {
    // struct {
        // errval_t err;
    // } args;
    // char bytes[RPC_MAX_LEN];
// } rpc_res_ram_cap;
typedef rpc_res rpc_res_ram_cap;

/* IRQICECAP */
// Request
typedef struct rpc_req_irq_cap_ {
    coreid_t coreid;
} rpc_req_irq_cap;

/*
 * DEVICECAP
 */
// Request
typedef struct rpc_req_dev_cap_ {
    lpaddr_t paddr;
    size_t bytes;
    coreid_t coreid;
} rpc_req_dev_cap;

// Response
// typedef union rpc_res_dev_cap_ {
    // struct {
        // errval_t err;
    // } args;
    // char bytes[RPC_MAX_LEN];
// } rpc_res_dev_cap;
typedef rpc_res rpc_res_dev_cap;

/*
 * Binding
 */
#define SERVICE_NAME_LEN RPC_MAX_LEN - RPC_RESERVED - sizeof(struct frame_identity)
typedef struct {
    struct frame_identity cap_fi;
    char service_name[SERVICE_NAME_LEN];
} rpc_remote_bind_req;

// typedef union rpc_remote_bind_res_ {
    // struct {
        // errval_t err;
    // } args;
    // char bytes[RPC_MAX_LEN];
// } rpc_remote_bind_res;
typedef rpc_res rpc_remote_bind_res;

// Read from serial
typedef struct {
    uint32_t len;
} rpc_req_read;

// Write to serial
typedef struct {
    uint16_t len;
    char buf[];
} rpc_req_puts;

// Process spawn
#define RPC_REQ_PROC_SPAWN_NAME (RPC_MAX_LEN-2)
typedef struct {
    coreid_t core_id;
    char name[];
} rpc_req_proc_spawn;
/* END RAMCAP */

typedef union rpc_res_proc_spawn {
    struct {
        errval_t err;
        uint8_t res_type;
        domainid_t pid;
    } args;
    char bytes[RPC_MAX_LEN];
} rpc_res_proc_spawn;

/**
 * CALLBACKS
 */
typedef struct lmp_chan_send_cb_s {
    uint8_t len;
    lmp_send_flags_t flags;
    struct capref cap;
    uintptr_t words[LMP_MSG_LENGTH];
} lmp_chan_send_cb_t;
#pragma pack(pop)


errval_t aos_rpc_send_capbuf(struct aos_rpc *chan, const char *str, size_t str_len, struct capref cap);
errval_t aos_rpc_rec_capbuf(struct aos_rpc *chan, char *buf, size_t* len, struct capref *cap);

errval_t aos_rpc_send_req(uint8_t type, struct aos_rpc *chan, const char *buf, size_t len, struct capref cap);
errval_t aos_rpc_rec_req(uint8_t * type, struct aos_rpc *chan, char **buf, size_t* len, struct capref *cap);

char* aos_rpc_receive_bind(void);
errval_t aos_rpc_new_remote_bind_4ever(char *service_name, size_t size, void** buf);
errval_t aos_rpc_new_remote_bind(char *service_name, struct capref frame, size_t size, void** res_buf);

void lmp_chan_send_cb(struct aos_rpc *chan, void* _args);

/** 
 * FUNCTIONS
 */

/**
 * \brief send a number over the given channel
 */
errval_t aos_rpc_send_number(struct aos_rpc *chan, uintptr_t val);

/**
 * \brief send a string over the given channel
 */
errval_t aos_rpc_send_string(struct aos_rpc *chan, const char *string);

/**
 * \brief request a RAM capability with >= request_bits of size over the given
 * channel.
 */
errval_t aos_rpc_get_ram_cap(struct aos_rpc *chan, size_t bytes, size_t align,
                             struct capref *retcap, size_t *ret_bytes);

/**
 * \brief get one character from the serial port
 */
errval_t aos_rpc_serial_getchar(struct aos_rpc *chan, char *retc);
errval_t aos_rpc_serial_read(struct aos_rpc *chan, char **retc, int len);

/**
 * \brief send one character to the serial port
 */
errval_t aos_rpc_serial_putchar(struct aos_rpc *chan, char c);
errval_t aos_rpc_serial_puts(struct aos_rpc *chan, const char* c, int len);
errval_t aos_rpc_register_service(struct aos_rpc *chan, const char* c);
    errval_t aos_rpc_bind_frame_with_service(struct aos_rpc *chan, const char* c, struct capref cap);

/**
 * \brief Request process manager to start a new process
 * \arg name the name of the process that needs to be spawned (without a
 *           path prefix)
 * \arg newpid the process id of the newly spawned process
 */
errval_t aos_rpc_process_spawn(struct aos_rpc *chan, char *name,
                               coreid_t core, domainid_t *newpid);

/**
 * \brief Get name of process with id pid.
 * \arg pid the process id to lookup
 * \arg name A null-terminated character array with the name of the process
 * that is allocated by the rpc implementation. Freeing is the caller's
 * responsibility.
 */
errval_t aos_rpc_process_get_name(struct aos_rpc *chan, domainid_t pid,
                                  char **name);

/**
 * \brief Get process ids of all running processes
 * \arg pids An array containing the process ids of all currently active
 * processes. Will be allocated by the rpc implementation. Freeing is the
 * caller's  responsibility.
 * \arg pid_count The number of entries in `pids' if the call was successful
 */
errval_t aos_rpc_process_get_all_pids(struct aos_rpc *chan,
                                      domainid_t **pids, size_t *pid_count);

/**
 * \brief Gets a capability to device registers
 * \param rpc  the rpc channel
 * \param paddr physical address of the device
 * \param bytes number of bytes of the device memory
 * \param frame returned devframe
 */
errval_t aos_rpc_get_device_cap(
        struct aos_rpc *rpc,
        lpaddr_t paddr,
        size_t bytes,
        struct capref *frame);

/**
 * \brief Gets a capability to irq
 * \param rpc  the rpc channel
 * \param frame returned devframe
 *
 * TODO: Implement Access Control for those caps.
 */
errval_t aos_rpc_get_irq_cap(struct aos_rpc *rpc,
                                struct capref *frame);

/**
 * \brief Initialize given rpc channel.
 */
errval_t aos_rpc_init(struct aos_rpc *rpc, struct capref endpoint);


/* Functions for bridging LMP with URPC
 *
 * Define generic send and ancillary data
 */
void aos_rpc_init_f(struct aos_rpc *rpc, 
        errval_t (*send_raw_f)(struct aos_rpc*, const char *,
            size_t, struct capref),
        errval_t (*send_req_f)(uint8_t type, struct aos_rpc*, const char *,
            size_t, struct capref),
        errval_t (*rec_raw_f)(struct aos_rpc*, char *,
            size_t*, struct capref*),
        errval_t (*rec_req_f)(uint8_t* type, struct aos_rpc*, char **,
            size_t*, struct capref*)
        );
void aos_rpc_init_a(struct aos_rpc *rpc, void * ancillary);
void * aos_rpc_get_a(struct aos_rpc *rpc);


/**
 * \brief Returns the RPC channel to init.
 */
struct aos_rpc *aos_rpc_get_init_channel(void);

/**
 * \brief Returns the channel to the memory server
 */
struct aos_rpc *aos_rpc_get_memory_channel(void);

/**
 * \brief Returns the channel to the process manager
 */
struct aos_rpc *aos_rpc_get_process_channel(void);

/**
 * \brief Returns the channel to the serial console
 */
struct aos_rpc *aos_rpc_get_serial_channel(void);

char* consume_readterm_buf(int count);
#endif // _LIB_BARRELFISH_AOS_MESSAGES_H

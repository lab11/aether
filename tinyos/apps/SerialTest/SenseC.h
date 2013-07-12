#ifndef SENSE_DEMO_H
#define SENSE_DEMO H

    typedef nx_struct configentry_t {
        nx_uint16_t zeroPoint;
        nx_uint16_t spanPoint;
        nx_uint16_t sampleInterval;
    } configentry_t;

    typedef nx_struct logentry_t {
        nx_uint16_t rawValue;
        nx_uint16_t calibratedValue;
    } logentry_t;
    
    typedef nx_struct logToSerialMsg {
        nx_uint16_t rawValue;
        nx_uint16_t calibratedValue;
        nx_uint16_t nodeid;
    } logToSerialMsg;

    typedef nx_struct commandMsg {
        nx_uint8_t commandByte;
        nx_uint16_t commandParam1;
    } commandMsg;

    enum {
        AM_ENVIR_SENSOR_MSG = 8,
        AM_ENVIR_SENSOR_CMD_MSG = 9,
        CMD_PAUSE = 1,
        CMD_ERASE = 2,
        CMD_READ = 3,
    };

    enum {
        STATE_WAITING = 0,
        STATE_SEND_DONE = 1,
        STATE_LOG_DONE = 2,
        STATE_SAMPLE = 3,

        STATE_LOG = 4,
        STATE_PAUSE = 5,
        AM_LOGTOSERIALMSG = 8,
    };

#endif

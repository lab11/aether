#include "AM.h"
#include "Serial.h"

#include "Timer.h"
#include "printf.h"
#include <I2C.h>


module SenseC {
    uses {
        interface Boot;
        interface Leds;
        interface Timer<TMilli>;
        interface HplMsp430GeneralIO as MEn;
        interface HplMsp430GeneralIO as ADCIn;

        interface AMSend as UartSend;
        interface Receive as UartReceive;
        interface Packet as UartPacket;
        interface AMPacket as UartAMPacket;
        interface SplitControl as SerialControl;

        interface LogRead;
        interface LogWrite;

        interface I2CPacket<TI2CBasicAddr>;
        interface Resource as I2CResource;
    }
}

implementation {
    // sampling frequency in binary milliseconds
    #define SAMPLING_FREQUENCY 1000
    
    uint8_t state;
    uint8_t state1;

    uint8_t sampleEngineState = STATE_SAMPLE;
    uint8_t sampleEngineEnabled = STATE_LOG;
       
    message_t pkt;
     

    configentry_t m_centry;
    logentry_t m_entry;

    bool m_busy = TRUE;

    event void LogRead.seekDone(error_t err) {}

    event void LogWrite.syncDone(error_t err) {}

    event void LogWrite.appendDone(void* buf, storage_len_t len, 
                                bool recordsLost, error_t err) {
        if(sampleEngineState == STATE_SEND_DONE) {
            sampleEngineState = STATE_SAMPLE;
            call Leds.led0Off();
        } else if(sampleEngineState == STATE_WAITING) {
            sampleEngineState = STATE_LOG_DONE;
        }
    }

    event void LogRead.readDone(void* buf, storage_len_t len, error_t err) {

        logToSerialMsg * ltrpkt;
        if((len == sizeof(logentry_t)) && (buf == &m_entry)) {
            //printf("Log Rec: %u\n", m_entry.rawValue);
            //printfflush();
            
            ltrpkt = (logToSerialMsg*)
                (call UartPacket.getPayload(&pkt, sizeof(logToSerialMsg)));
            ltrpkt->rawValue = m_entry.rawValue;

            if(call UartSend.send(AM_BROADCAST_ADDR, &pkt, sizeof(logToSerialMsg)) != SUCCESS) {
            
            }

        }
        else {
            sampleEngineEnabled = STATE_LOG;
        }
    }

    event void LogWrite.eraseDone(error_t err) {
        sampleEngineEnabled = STATE_LOG;
    }

    task void perform_data_collection() {
        uint16_t j;
        uint16_t finalValue;
        uint32_t adcPointCollection = 0;
        uint8_t seq1[2] = {0x12, 0x07};
        uint8_t seq2[2] = {0x12, 0x03};
        error_t error = SUCCESS;
        logToSerialMsg * ltrpkt;

            for(j = 0; j < 255; j++) {
                atomic {
                    ADC12CTL0 |= ENC;
                    ADC12CTL0 |= ADC12SC;
                }
                call Leds.led2On();
                while((ADC12IFG & 0x1) == 0);
                atomic {
                    ADC12IFG = 0;
                }
                call Leds.led2Off();
                adcPointCollection += ADC12MEM0;
            }

            finalValue = (adcPointCollection >> 4);
            //printf("Measured value %u\n", finalValue);
            if(sampleEngineState == STATE_SAMPLE) {
                call Leds.led0On();
                sampleEngineState = STATE_WAITING;
                m_entry.rawValue = finalValue;
                ltrpkt = (logToSerialMsg*)
                    (call UartPacket.getPayload(&pkt, sizeof(logToSerialMsg)));
                ltrpkt->rawValue = finalValue;

                if(call LogWrite.append(&m_entry, sizeof(logentry_t)) != SUCCESS) {
                    sampleEngineState = STATE_LOG_DONE;
                }
                if(call UartSend.send(AM_BROADCAST_ADDR, &pkt, sizeof(logToSerialMsg)) != SUCCESS) {
                    if(sampleEngineState == STATE_LOG_DONE) {
                        sampleEngineState = STATE_SAMPLE;
                    } else {
                        sampleEngineState = STATE_SEND_DONE;
                    }
                }
            }
    }

    task void perform_i2c_action() {
        error_t error = SUCCESS;
        uint8_t seq1[10] = {0x01, 0x00, 0x10, 0x00, 0x11, 0x20, 0x12, 0x03, 0x01, 0x01};

        //printf("Perform I2C Action: %d", state);
        //printfflush();
        do {
            //Write the packet using the state as an offset calculation.
            error = call I2CPacket.write((I2C_START | I2C_STOP), 72, 2, seq1 + (state*2));
        } while (error != SUCCESS);
        atomic { state++; }
    }
    
    async event void I2CPacket.writeDone(error_t error, uint16_t addr, 
        uint8_t length, uint8_t* data) {
        if(state == 5) {
            call I2CResource.release();
            call Leds.led1Off();
            call Timer.startPeriodic(SAMPLING_FREQUENCY);
        } else {
            post perform_i2c_action();
        }
    }

    async event void I2CPacket.readDone(error_t error, uint16_t addr, 
        uint8_t length, uint8_t* data) {
    }

    event void I2CResource.granted() {
      post perform_i2c_action();
    }

  event void Boot.booted() {
    call Leds.led1On();
    call SerialControl.start();
  }

  event void SerialControl.startDone(error_t err) {
    if(err == SUCCESS) {
      m_busy = FALSE; 
      call ADCIn.makeInput();
      call ADCIn.selectModuleFunc();
      call MEn.makeOutput();
      call MEn.clr();
      atomic {
          ADC12CTL0 = ADC12ON + SHT0_7;
          ADC12CTL1 = CSTARTADD_0 + SHP;
          ADC12MCTL0 = INCH_0;
          ADC12MCTL0 = EOS;
      }

      call I2CResource.request();
      call Leds.led1Off();
    } else {
          call SerialControl.start();
    }
  }

  event void UartSend.sendDone(message_t* msg, error_t error) {
    //  if(&pkt == msg) {
          if(sampleEngineEnabled == STATE_PAUSE) {
            call LogRead.read(&m_entry, sizeof(logentry_t));
          } else {
            if(sampleEngineState == STATE_WAITING) {
                sampleEngineState = STATE_SEND_DONE;
            } else {
                sampleEngineState = STATE_SAMPLE;
                call Leds.led0Off();
            }
          }
     // }
  }

  event void Timer.fired() 
  {
    call Leds.led1On();
    if(sampleEngineEnabled == STATE_LOG) {
      post perform_data_collection();
    }
  }

  event message_t* UartReceive.receive(message_t* msg, void* payload, uint8_t len) {
   commandMsg * cmdMsg = (commandMsg *) payload;
   switch(cmdMsg->commandByte) {
      case CMD_ERASE:
        sampleEngineEnabled = STATE_PAUSE; 
        call LogWrite.erase();
      break;
      
      case CMD_READ:
        sampleEngineEnabled = STATE_PAUSE;
        call LogRead.read(&m_entry, sizeof(logentry_t)); 
      break;       
   };

   return msg; 
  }

  event void SerialControl.stopDone(error_t err) {}

}

#include "printf.h"
#include "StorageVolumes.h"
#include "SenseC.h"


configuration SenseAppC 
{ 
} 
implementation { 
  
  components SenseC, MainC, LedsC, new TimerMilliC();
  components HplMsp430GeneralIOC as GeneralIOC;
  components SerialActiveMessageC as Serial;
  components new SerialAMSenderC(0x07);  
  components new SerialAMReceiverC(0x07);

  // DataFlash Code
  components new LogStorageC(VOLUME_LOGTEST, TRUE);
  SenseC.LogRead -> LogStorageC;
  SenseC.LogWrite -> LogStorageC;
  
  // Serial Port Code
  SenseC.SerialControl -> Serial;
  SenseC.UartSend -> SerialAMSenderC; 
  SenseC.UartReceive -> SerialAMReceiverC;
  SenseC.UartPacket -> Serial;
  SenseC.UartAMPacket -> Serial;

  // Standard Code
  SenseC.Boot -> MainC;
  SenseC.Leds -> LedsC;
  SenseC.Timer -> TimerMilliC;
  SenseC.ADCIn -> GeneralIOC.Port60;
  SenseC.MEn -> GeneralIOC.Port55;
  components new Msp430I2CC();
  SenseC.I2CResource -> Msp430I2CC.Resource;
  SenseC.I2CPacket -> Msp430I2CC.I2CBasicAddr;
}

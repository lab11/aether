#include "SimplePacket.h"
#include <Timer.h>
#include <IPDispatch.h>
#include <lib6lowpan/lib6lowpan.h>
#include <lib6lowpan/ip.h>


module SimplePacketP {
	uses interface Timer<TMilli> as Timer0;

	uses interface Leds;
	uses interface Boot;

	uses interface HplMsp430GeneralIO as VoltRegPwr;
	uses interface SplitControl as RadioControl;
	uses interface UDP as UDPService;
	
}

implementation {

	nx_struct simple_pkt_t payload;
	error_t err;
	struct sockaddr_in6 dest;

	event void Boot.booted () {

		atomic {
			// Turn on secondary regulator.
			call VoltRegPwr.selectIOFunc();
			call VoltRegPwr.makeOutput();
			call VoltRegPwr.set();

			call Leds.led0On();
			
			payload.seqno = 0;

			call RadioControl.start();  //Turn on radio
		}
	}

	event void RadioControl.startDone (error_t e) {
		if (e == SUCCESS) {
			call Timer0.startPeriodic(30000); 
		} else {
			call RadioControl.start();
		}
	}

	event void Timer0.fired() {
		atomic {
			payload.seqno++;
		}

		inet_pton6(RECEIVER_ADDR, &dest.sin6_addr);
		dest.sin6_port = htons(RECEIVER_PORT);

		err = call UDPService.sendto(&dest, &payload, sizeof(nx_struct simple_pkt_t));

		if (err == SUCCESS) call Leds.led1Toggle();
		else call Leds.led0Toggle();
	}
  
	event void UDPService.recvfrom (struct sockaddr_in6 *from, void *data, uint16_t len, struct ip6_metadata *meta) { }
	
	event void RadioControl.stopDone (error_t e) { }

}

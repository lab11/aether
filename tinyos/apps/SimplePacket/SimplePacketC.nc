
configuration SimplePacketC {
}
implementation {

	components MainC, SimplePacketP;

#ifdef USE_LEDS
	components LedsC as Led;
#else
	components NoLedsC as Led;
#endif

	components IPStackC;
//	components IPDispatchC;
	
	components new TimerMilliC()	as Timer0;
	components new UdpSocketC()		as UDPService;
	components HplMsp430GeneralIOC	as Gpio;

	SimplePacketP -> MainC.Boot;

	SimplePacketP.Timer0 -> Timer0;

	SimplePacketP.Leds -> Led;

	SimplePacketP.VoltRegPwr -> Gpio.Port57;

	// Radio 
	SimplePacketP.RadioControl		-> IPStackC;
	SimplePacketP.UDPService		-> UDPService;

	// UDP shell on port 2000
	components UDPShellC;

	// prints the routing table
	components RouteCmdC;
	
#ifdef RPL_ROUTING
	components RPLRoutingC;
#endif

}

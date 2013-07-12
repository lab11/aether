COMPONENT=SimplePacketC

#CFLAGS += -DCC2420_DEF_CHANNEL=21

# you can compile with or without a routing protocol... of course,
# without it, you will only be able to use link-local communication.
PFLAGS += -DRPL_ROUTING -DRPL_STORING_MODE -I$(LOWPAN_ROOT)/tos/lib/net/rpl

# tell the 6lowpan layer to not generate hc-compressed headers
#PFLAGS += -DLIB6LOWPAN_HC_VERSION=-1

# if you're using DHCP, set this to try and derive a 16-bit address
# from the IA received from the server.  This will work if the server
# gives out addresses from a /112 prefix.  If this is not set, blip
# will only use EUI64-based link addresses.
#PFLAGS += -DBLIP_DERIVE_SHORTADDRS

# this disables dhcp and statically chooses a prefix.  the motes form
# their ipv6 address by combining this with TOS_NODE_ID
PFLAGS += -DIN6_PREFIX=\"2607:f018:8000:bbbc::\"

# the sleep interval needs to be set the same for all participating devices
CFLAGS += -DLOW_POWER_LISTENING -DLPL_SLEEP_INTERVAL=512 -DLPL_DEF_LOCAL_WAKEUP=512 -DLPL_DEF_REMOTE_WAKEUP=512
# also modifiy blip's L2 parameters to reduce media overload
CFLAGS += -DBLIP_L2_RETRIES=2 -DBLIP_L2_DELAY=512

# Set the address and port to send the packets to
CFLAGS += -DRECEIVER_ADDR=\"2607:f018:8000:bbbc::1\"
CFLAGS += -DRECEIVER_PORT=4000

# Whether or not to use the LEDs
CFLAGS += -DUSE_LEDS

include $(MAKERULES)

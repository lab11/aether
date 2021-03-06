/**
 * This class is automatically generated by mig. DO NOT EDIT THIS FILE.
 * This class implements a Java interface to the 'logToSerialMsg'
 * message type.
 */

public class logToSerialMsg extends net.tinyos.message.Message {

    /** The default size of this message type in bytes. */
    public static final int DEFAULT_MESSAGE_SIZE = 6;

    /** The Active Message type associated with this message. */
    public static final int AM_TYPE = 8;

    /** Create a new logToSerialMsg of size 6. */
    public logToSerialMsg() {
        super(DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /** Create a new logToSerialMsg of the given data_length. */
    public logToSerialMsg(int data_length) {
        super(data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new logToSerialMsg with the given data_length
     * and base offset.
     */
    public logToSerialMsg(int data_length, int base_offset) {
        super(data_length, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new logToSerialMsg using the given byte array
     * as backing store.
     */
    public logToSerialMsg(byte[] data) {
        super(data);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new logToSerialMsg using the given byte array
     * as backing store, with the given base offset.
     */
    public logToSerialMsg(byte[] data, int base_offset) {
        super(data, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new logToSerialMsg using the given byte array
     * as backing store, with the given base offset and data length.
     */
    public logToSerialMsg(byte[] data, int base_offset, int data_length) {
        super(data, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new logToSerialMsg embedded in the given message
     * at the given base offset.
     */
    public logToSerialMsg(net.tinyos.message.Message msg, int base_offset) {
        super(msg, base_offset, DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new logToSerialMsg embedded in the given message
     * at the given base offset and length.
     */
    public logToSerialMsg(net.tinyos.message.Message msg, int base_offset, int data_length) {
        super(msg, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
    /* Return a String representation of this message. Includes the
     * message type name and the non-indexed field values.
     */
    public String toString() {
      String s = "Message <logToSerialMsg> \n";
      try {
        s += "  [rawValue=0x"+Long.toHexString(get_rawValue())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [calibratedValue=0x"+Long.toHexString(get_calibratedValue())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [nodeid=0x"+Long.toHexString(get_nodeid())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      return s;
    }

    // Message-type-specific access methods appear below.

    /////////////////////////////////////////////////////////
    // Accessor methods for field: rawValue
    //   Field type: int, unsigned
    //   Offset (bits): 0
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'rawValue' is signed (false).
     */
    public static boolean isSigned_rawValue() {
        return false;
    }

    /**
     * Return whether the field 'rawValue' is an array (false).
     */
    public static boolean isArray_rawValue() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'rawValue'
     */
    public static int offset_rawValue() {
        return (0 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'rawValue'
     */
    public static int offsetBits_rawValue() {
        return 0;
    }

    /**
     * Return the value (as a int) of the field 'rawValue'
     */
    public int get_rawValue() {
        return (int)getUIntBEElement(offsetBits_rawValue(), 16);
    }

    /**
     * Set the value of the field 'rawValue'
     */
    public void set_rawValue(int value) {
        setUIntBEElement(offsetBits_rawValue(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'rawValue'
     */
    public static int size_rawValue() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'rawValue'
     */
    public static int sizeBits_rawValue() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: calibratedValue
    //   Field type: int, unsigned
    //   Offset (bits): 16
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'calibratedValue' is signed (false).
     */
    public static boolean isSigned_calibratedValue() {
        return false;
    }

    /**
     * Return whether the field 'calibratedValue' is an array (false).
     */
    public static boolean isArray_calibratedValue() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'calibratedValue'
     */
    public static int offset_calibratedValue() {
        return (16 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'calibratedValue'
     */
    public static int offsetBits_calibratedValue() {
        return 16;
    }

    /**
     * Return the value (as a int) of the field 'calibratedValue'
     */
    public int get_calibratedValue() {
        return (int)getUIntBEElement(offsetBits_calibratedValue(), 16);
    }

    /**
     * Set the value of the field 'calibratedValue'
     */
    public void set_calibratedValue(int value) {
        setUIntBEElement(offsetBits_calibratedValue(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'calibratedValue'
     */
    public static int size_calibratedValue() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'calibratedValue'
     */
    public static int sizeBits_calibratedValue() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: nodeid
    //   Field type: int, unsigned
    //   Offset (bits): 32
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'nodeid' is signed (false).
     */
    public static boolean isSigned_nodeid() {
        return false;
    }

    /**
     * Return whether the field 'nodeid' is an array (false).
     */
    public static boolean isArray_nodeid() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'nodeid'
     */
    public static int offset_nodeid() {
        return (32 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'nodeid'
     */
    public static int offsetBits_nodeid() {
        return 32;
    }

    /**
     * Return the value (as a int) of the field 'nodeid'
     */
    public int get_nodeid() {
        return (int)getUIntBEElement(offsetBits_nodeid(), 16);
    }

    /**
     * Set the value of the field 'nodeid'
     */
    public void set_nodeid(int value) {
        setUIntBEElement(offsetBits_nodeid(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'nodeid'
     */
    public static int size_nodeid() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'nodeid'
     */
    public static int sizeBits_nodeid() {
        return 16;
    }

}

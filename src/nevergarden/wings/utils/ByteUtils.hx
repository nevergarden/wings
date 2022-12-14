package nevergarden.wings.utils;

import haxe.io.Bytes;

class ByteUtils {
    public static inline function getu8(offset:Int, bytes:Bytes):UInt {
        var b0 : UInt = bytes.get(offset);
        return b0;
    }

    public static inline function getu16(offset:Int, bytes:Bytes):UInt {
        var b0 : Int = bytes.get(offset + 1);
        var b1 : Int = bytes.get(offset);
        return (b1 << 8 | b0);
    }

    public static inline function getu32(offset:Int, bytes:Bytes):UInt {
        var b0 : Int = bytes.get(offset + 3);
        var b1 : Int = bytes.get(offset + 2);
        var b2 : Int = bytes.get(offset + 1);
        var b3 : Int = bytes.get(offset);
        return (b3 << 24 | b2 << 16 | b1 << 8 | b0);
    }

    public static inline function getf64(offset:Int, bytes:Bytes):Float {
        var b0 : Int = bytes.get(offset + 7);
        var b1 : Int = bytes.get(offset + 6);
        var b2 : Int = bytes.get(offset + 5);
        var b3 : Int = bytes.get(offset + 4);
        var b4 : Int = bytes.get(offset + 3);
        var b5 : Int = bytes.get(offset + 2);
        var b6 : Int = bytes.get(offset + 1);
        var b7 : Int = bytes.get(offset);

        return (b7 << 56 | b6 << 48 | b5 << 40 | b4 << 32 | b3 << 24 | b2 << 16 | b1 << 8 | b0);
    }

    private static inline function is_safe_offset(bytes:Bytes, offset:UInt, margin:UInt):Bool {
        if(offset > bytes.length) return false;
        if(bytes.length - offset < margin) return false;
        return true;
    }
}
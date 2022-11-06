package nevergarden.wings.utils;

class ByteUtils {
    public static function getu32(offset:Int, bytes:haxe.io.Bytes) {
        var b0 : Int = bytes.get(offset + 3);
        var b1 : Int = bytes.get(offset + 2);
        var b2 : Int = bytes.get(offset + 1);
        var b3 : Int = bytes.get(offset);
        return (b3 << 24 | b2 << 16 | b1 << 8 | b0);
    }
}
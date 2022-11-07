package nevergarden.wings;

import nevergarden.wings.ds.FontTable;
import nevergarden.wings.utils.ByteUtils;
import haxe.Resource;
import haxe.Exception;
import haxe.io.Bytes;
import sys.io.FileInput;
import sys.io.File;

class Wings {
    static final FILE_MAGIC_ONE:Int = 0x00010000;
    static final FILE_MAGIC_TWO:Int = 0x74727565;

    private var mem : Bytes;
    public function new(fontBytes : haxe.io.Bytes) {
        this.mem = fontBytes;
    }

    public static function load_from_path(path:String) {
        var file : FileInput = File.read(path, true);
        var bytes : haxe.io.Bytes = file.readAll();
        load_file(bytes);
    }

    public static function load_from_resource_name(name:String) {
        var bytes : haxe.io.Bytes = Resource.getBytes(name);
        if(bytes == null)
            throw new Exception("");

        load_file(bytes);
    }

    private static function load_file(bytes:Bytes) {
        if(bytes.length < 12)
            throw new Exception("");
        var magic = ByteUtils.getu32(0, bytes);
        if(magic != FILE_MAGIC_ONE && magic != FILE_MAGIC_TWO)
            throw new Exception("");
        var headTable = gettable(bytes, "head");
        var head = bytes.sub(headTable.offset, headTable.length);
        trace(ByteUtils.getu32(0, head) == 0x00010000);
    }

    private static function gettable(bytes:Bytes, tag:String):FontTable {
        var tableCount = ByteUtils.getu16(4, bytes);
        var match : Int = -1;
        for(i in 0...tableCount) {
            if(bytes.getString(12+i*16, 4) == tag) {
                match = 12+i*16;
            }
        }

        if(match == -1)
            throw new Exception("Does not have table with tag: " + tag);

        var fontTable : FontTable = new FontTable({
            tag: tag,
            checksum: ByteUtils.getu32(match+4, bytes),
            offset: ByteUtils.getu32(match+8, bytes),
            length: ByteUtils.getu32(match+12, bytes),
        });
        return fontTable;
    }
}
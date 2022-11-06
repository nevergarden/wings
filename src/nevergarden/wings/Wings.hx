package nevergarden.wings;

import nevergarden.wings.utils.ByteUtils;
import eval.luv.SockAddr.AddressFamily;
import haxe.Resource;
import haxe.Exception;
import haxe.io.Bytes;
import sys.io.FileInput;
import sys.io.File;

class Wings {
    static final FILE_MAGIC_ONE:Int = 0x00010000;
    public function new(fontBytes : haxe.io.Bytes) {
        
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

    private static function load_file(bytes:haxe.io.Bytes) {
        if(bytes.length < 12)
            throw new Exception("");
        var magic = ByteUtils.getu32(0, bytes);
    }
}
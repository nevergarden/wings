package nevergarden.wings;

import nevergarden.wings.parsers.OpenTypeParser;
import nevergarden.wings.utils.ByteUtils;
import haxe.Resource;
import haxe.Exception;
import haxe.io.Bytes;
import sys.io.FileInput;
import sys.io.File;

class Wings {

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
        var opTyp : OpenTypeParser = new OpenTypeParser(bytes);
    }
}
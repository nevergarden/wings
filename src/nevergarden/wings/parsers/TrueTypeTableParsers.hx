package nevergarden.wings.parsers;

import haxe.Exception;
import nevergarden.wings.utils.ByteUtils;
import haxe.io.Bytes;

enum abstract PlatformID(UInt) {
    var Unicode = 0;
    var Macintosh = 1;
    var Microsoft = 3;
}

typedef CMAPSubtableType = {
    var platformID  : PlatformID;
    var platformSpecificID : UInt;
    var offset : UInt;
}

class CMAPParser {
    private var offset:UInt;
    private final data:Bytes;
    private var subTableCount:UInt = 0;

    private final subtables : Array<CMAPSubtableType> = new Array<CMAPSubtableType>();
    public function new(bytes:Bytes) {
        this.data = bytes;
        this.offset = 0;
        parseIndex();
        parseSubtables();
    }

    private function parseIndex() {
        var version : UInt = ByteUtils.getu16(offset, data);
        offset+=2;
        this.subTableCount = ByteUtils.getu16(offset, data);
        offset+=2;
    }

    private function parseSubtables() {
        for (i in 0...subTableCount) {
            var subTable : CMAPSubtableType = {
                platformID: cast(ByteUtils.getu16(offset, data), PlatformID),
                platformSpecificID: ByteUtils.getu16(offset+2, data),
                offset: ByteUtils.getu32(offset+4, data)
            }
            offset+=8;
            subtables.push(subTable);
        }
        trace(subtables);
    }
}

typedef HeadType = {
    var version	: UInt;
    var fontRevision : UInt;
    var checkSumAdjustment : UInt;
    var flags : UInt;
    var unitsPerEm : UInt;
    var created	: Date;
    var modified : Date;
    var xMin : UInt;
    var yMin : UInt;
    var xMax : UInt;
    var yMax : UInt;
    var macStyle : UInt;
    var lowestRecPPEM : UInt;
    var fontDirectionHint : Int;
    var indexToLocFormat : UInt;
    var glyphDataFormat : UInt;
}

class HEADParser {
    static final MAGIC:Int = 0x5F0F3CF5;
    private var offset : UInt;
    private final data:Bytes;

    public var parsed : HeadType = {
        version	: 0,
        fontRevision : 0,
        checkSumAdjustment : 0,
        flags : 0,
        unitsPerEm : 0,
        created	: Date.fromTime(0),
        modified : Date.fromTime(0),
        xMin : 0,
        yMin : 0,
        xMax : 0,
        yMax : 0,
        macStyle : 0,
        lowestRecPPEM : 0,
        fontDirectionHint : 0,
        indexToLocFormat : 0,
        glyphDataFormat : 0,
    }

    public function new(bytes:Bytes) {
        this.data = bytes;
        this.offset = 0;
        parse();
    }

    private function parse() {
        parsed.version = parse32();
        parsed.fontRevision = parse32();
        parsed.checkSumAdjustment = parse32();
 
        if( ByteUtils.getu32(offset, data) != MAGIC )
            throw new Exception("Magic of head is not correct.");
        offset+=4;

        parsed.flags = parse16();
        parsed.unitsPerEm = parse16();
        // TODO: find a way to convert this date.
        offset += 16;
        // parsed.created = parseDate();
        // parsed.modified = parseDate();
        parsed.xMin = parse16();
        parsed.yMin = parse16();
        parsed.xMax = parse16();
        parsed.yMax = parse16();
        parsed.macStyle = parse16();
        parsed.lowestRecPPEM = parse16();
        parsed.fontDirectionHint = parse16();
        parsed.indexToLocFormat = parse16();
        parsed.glyphDataFormat = parse16();
    }

    private function parse16() : UInt {
        var x = ByteUtils.getu16(offset, data);
        offset+=2;
        return x;
    }

    private function parse32() : UInt {
        var x = ByteUtils.getu32(offset, data);
        offset+=4;
        return x;
    }

    private function parseDate() : Date {
        var x = ByteUtils.getf64(offset, data);
        offset+=8;
        return Date.fromTime(x);
    }
}
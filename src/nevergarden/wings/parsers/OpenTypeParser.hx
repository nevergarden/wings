package nevergarden.wings.parsers;

import haxe.xml.Check;
import nevergarden.wings.ds.OpenTypeTableRecord;
import haxe.Exception;
import nevergarden.wings.utils.ByteUtils;
import haxe.io.Bytes;

class OpenTypeParser {
    static final FILE_MAGIC_ONE:Int = 0x00010000;
    static final FILE_MAGIC_TWO:Int = 0x74727565;

    private final data:Bytes;
    private var offset:Int = 0;
    private var sfntVersion : UInt = 0;
    private var tableCount : UInt = 0;
    private var searchRange : UInt = 0;
    private var entrySelector : UInt = 0;
    private var rangeShift : UInt = 0;
    private final tableRecords : Map<String, OpenTypeTableRecord> = new Map<String, OpenTypeTableRecord>();

    public function new(bytes:Bytes) {
        this.offset = 0;
        this.data = bytes;
        parse();
    }

    private function parse() {
        parseTableDirectory();
    }

    private function parseTableDirectory() {
        this.sfntVersion = ByteUtils.getu32(offset, this.data);
        this.offset += 4;
        if(this.sfntVersion != FILE_MAGIC_ONE && this.sfntVersion != FILE_MAGIC_TWO)
            throw new Exception("Magic is not correct check filetype.");
        
        this.tableCount = ByteUtils.getu16(offset, this.data);
        this.offset += 2;

        this.searchRange = ByteUtils.getu16(offset, this.data);
        this.offset += 2;

        this.entrySelector = ByteUtils.getu16(offset, this.data);
        this.offset += 2;
        
        this.rangeShift = ByteUtils.getu16(offset, this.data);
        this.offset += 2;
        
        parseTables();
    }

    private function parseTables() {
        for (record in 0...tableCount) {
            var tableRecord : OpenTypeTableRecord = new OpenTypeTableRecord({
                tag:   this.data.getString(offset, 4),
                checksum: ByteUtils.getu32(offset + 4, data),
                offset:   ByteUtils.getu32(offset + 8, data),
                length:   ByteUtils.getu32(offset + 12, data)
            });
            offset+=16;
            tableRecords.set(tableRecord.tag, tableRecord);
        }
    }
}
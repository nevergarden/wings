package nevergarden.wings.ds;

typedef OpenTypeTableRecordType = {
    var tag : String;
    var checksum : UInt;
    var offset : UInt;
    var length : UInt;
}

abstract OpenTypeTableRecord(OpenTypeTableRecordType) {
    public var tag(get, set):String;

    function get_tag() {
        return this.tag;
    }

    function set_tag(value) {
        return this.tag = tag;
    }

    public var checksum(get, set):UInt;

    function get_checksum() {
        return this.checksum;
    }

    function set_checksum(value) {
        return this.checksum = value;
    }

    public var offset(get, set):UInt;

    function get_offset() {
        return this.offset;
    }

    function set_offset(value) {
        return this.offset = value;
    }

    public var length(get, set):UInt;

    function get_length() {
        return this.length;
    }

    function set_length(value) {
        return this.length = value;
    }


    public function new(value : OpenTypeTableRecordType) {
        this = value;
    }
}
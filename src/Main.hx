package;

import nevergarden.wings.Wings;
import haxe.Resource;

class Main {
    static function main() {
        Wings.load_from_resource_name("fira");
        Wings.load_from_path("res/FiraGO-Regular.ttf");
    }
}
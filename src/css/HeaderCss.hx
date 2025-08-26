package css;

class HeaderCss {
    public static function use() {
        #if js
        js.Syntax.code('require("./Header.css")');
        #end
    }
}
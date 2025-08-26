package css;

class AppCss {
    public static function use() {
        #if js
        js.Syntax.code('require("./App.css")');
        #end
    }
}
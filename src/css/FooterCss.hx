package css;

class FooterCss {
    public static function use() {
        #if js
        js.Syntax.code('require("./Footer.css")');
        #end
    }
}
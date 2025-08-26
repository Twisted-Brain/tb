package css;

class RepoListCss {
    public static function use() {
        #if js
        js.Syntax.code('require("./RepoList.css")');
        #end
    }
}
package components;

import react.React;
import react.ReactComponent;
import react.ReactMacro.jsx;
import css.HeaderCss;

@:css(HeaderCss.use)
class Header extends ReactComponent {
    override function render() {
        return jsx('
            <header>
                <h1>Twisted Brain AI</h1>
                <h2>Haxe/React Project Showcase</h2>
            </header>
        ');
    }
}
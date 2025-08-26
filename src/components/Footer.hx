package components;

import react.React;
import react.ReactComponent;
import react.ReactMacro.jsx;
import css.FooterCss;

@:css(FooterCss.use)
class Footer extends ReactComponent {
    override function render() {
        return jsx('
            <footer>
                <p>&copy; 2024 Twisted Brain AI - Haxe DevOps Project</p>
                <p>Built with Haxe and React</p>
            </footer>
        ');
    }
}
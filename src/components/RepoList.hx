package components;

import react.React;
import react.ReactComponent;
import react.ReactMacro.jsx;
import css.RepoListCss;

@:css(RepoListCss.use)
class RepoList extends ReactComponent {
    override function render() {
        return jsx('
            <div className="repo-list">
                <p>Repository list will be displayed here.</p>
            </div>
        ');
    }
}
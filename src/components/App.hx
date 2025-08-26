package components;

import react.React;
import react.ReactComponent;
import react.ReactMacro.jsx;
import css.AppCss;
import components.Header;
import components.RepoList;
import components.Footer;

@:css(AppCss.use)
class App extends ReactComponent {
  override function render() {
    return jsx('
      <div className="app">
        <Header />
        <main className="main-content">
          <RepoList />
        </main>
        <Footer />
      </div>
    ');
  }
}
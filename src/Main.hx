import react.React;
import react.ReactDOM;
import components.App;
import js.Browser;

class Main {
  static function main() {
    final container = Browser.document.getElementById('app');
    ReactDOM.render(React.createElement(App, null), container);
  }
}
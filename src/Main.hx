import react.React;
import react.ReactDOM;
import react.ReactComponent;
import components.Hero;
import components.About;
import components.Features;
import components.Showcase;
import components.Community;
import components.Footer;

class Main {
  static public function main() {
    ReactDOM.render(React.createElement(App, null), js.Browser.document.getElementById('app'));
  }
}

class App extends ReactComponent {
  override function render() {
    return React.createElement('div', null, [
      React.createElement(Hero, { key: 'hero' }),
      React.createElement(About, { key: 'about' }),
      React.createElement(Features, { key: 'features' }),
      React.createElement(Showcase, { key: 'showcase' }),
      React.createElement(Community, { key: 'community' }),
      React.createElement(Footer, { key: 'footer' })
    ]);
  }
}
package components;

import react.React;

import react.ReactComponent;

class Hero extends ReactComponent {
  override function render() {
    return React.createElement('section', { className: 'hero' }, [
      React.createElement('div', { className: 'hero-content' }, [
        React.createElement('h1', null, 'AI + Human: The Future of DevOps'),
        React.createElement('p', null, 'Building, testing, and scaling with Haxe, bridging code, AI agents, and human creativity.'),
        React.createElement('div', null, [
          React.createElement('a', { href: '#', className: 'btn btn-primary' }, 'Get Started'),
          React.createElement('a', { href: 'https://github.com/Twisted-Brain', className: 'btn btn-secondary' }, 'View on GitHub')
        ])
      ])
    ]);
  }
}
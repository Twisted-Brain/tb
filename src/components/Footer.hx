package components;

import react.React;

import react.ReactComponent;

class Footer extends ReactComponent {
  override function render() {
    return React.createElement('footer', { className: 'footer' }, [
      React.createElement('div', { className: 'footer-links' }, [
        React.createElement('a', { href: 'https://github.com/Twisted-Brain' }, 'GitHub'),
        React.createElement('a', { href: '#' }, 'Docs'),
        React.createElement('a', { href: '#' }, 'Roadmap'),
        React.createElement('a', { href: '#' }, 'Contact')
      ]),
      React.createElement('img', { src: 'public/assets/logo.png', alt: 'Twisted Brain Logo', className: 'footer-logo' }),
      React.createElement('p', null, '© 2024 Twisted Brain DevOps Project')
    ]);
  }
}
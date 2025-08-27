package components;

import react.React;

import react.ReactComponent;

class Community extends ReactComponent {
  override function render() {
    return React.createElement('section', { id: 'community', className: 'section' }, [
      React.createElement('h2', null, 'Community & Open Source'),
      React.createElement('p', null, 'Twisted Brain is open-source, transparent, and community-driven.'),
      React.createElement('a', { href: 'https://github.com/Twisted-Brain', className: 'btn btn-primary' }, 'Contribute on GitHub')
    ]);
  }
}
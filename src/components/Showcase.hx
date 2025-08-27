package components;

import react.React;

import react.ReactComponent;

class Showcase extends ReactComponent {
  override function render() {
    return React.createElement('section', { id: 'showcase', className: 'section' }, [
      React.createElement('h2', null, 'Showcase / Demo'),
      React.createElement('p', null, '// TODO: REMOVE - Add styled mockups and code cycle diagram here.'),
      React.createElement('img', { src: 'public/assets/hdevm_4.png', alt: 'Showcase Image', style: { width: '80%', marginTop: '2rem' } })
    ]);
  }
}
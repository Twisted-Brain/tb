package components;

import react.React;

import react.ReactComponent;

class About extends ReactComponent {
  override function render() {
    return React.createElement('section', { id: 'about', className: 'section' }, [
      React.createElement('h2', null, 'About Twisted Brain'),
      React.createElement('p', null, 'We are developers shaping the future with Haxe and AI.'),
      React.createElement('p', null, 'AI-assisted development for multi-target Haxe projects, human–AI collaboration in DevOps cycles (code → test → validate → deploy), focusing on simplicity, automation, and creativity.'),
      React.createElement('img', { src: 'assets/tb.png', alt: 'Twisted Brain Logo', style: { width: '150px' } })
    ]);
  }
}
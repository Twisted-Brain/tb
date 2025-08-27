package components;

import react.React;

import react.ReactComponent;

class Features extends ReactComponent {
  override function render() {
    return React.createElement('section', { id: 'features', className: 'section' }, [
      React.createElement('h2', null, 'Key Features'),
      React.createElement('div', { className: 'features-grid' }, [
        React.createElement('div', { className: 'feature-card' }, [
          React.createElement('img', { src: 'assets/hdevm_1.png', alt: 'AI DevOps Pipeline' }),
          React.createElement('h3', null, 'AI DevOps Pipeline'),
          React.createElement('p', null, 'Automates repetitive coding/testing with intelligent agents.')
        ]),
        React.createElement('div', { className: 'feature-card' }, [
          React.createElement('img', { src: 'assets/xrd.png', alt: 'Multi-Target Haxe Development' }),
          React.createElement('h3', null, 'Multi-Target Haxe Development'),
          React.createElement('p', null, 'Compile once, run everywhere (JS, C++, Java, PHP, Lua, etc.).')
        ]),
        React.createElement('div', { className: 'feature-card' }, [
          React.createElement('img', { src: 'assets/tb_3.png', alt: 'Human + AI Collaboration' }),
          React.createElement('h3', null, 'Human + AI Collaboration'),
          React.createElement('p', null, 'AI proposes, humans refine to balance creativity and efficiency.')
        ])
      ])
    ]);
  }
}
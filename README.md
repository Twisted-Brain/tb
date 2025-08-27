# Twisted Brain Pages

A modern landing page built with Haxe, showcasing AI-assisted development workflows and multi-target compilation capabilities.

## Overview

Twisted Brain Pages demonstrates the power of Haxe for cross-platform development, featuring:
- AI DevOps Pipeline integration
- Multi-target Haxe compilation (JavaScript, C++, HashLink)
- Modern neon-themed UI with animations
- Comprehensive testing suite (Unit, Integration, E2E)
- Automated build and deployment workflows

## Prerequisites

- **Haxe 4.3+**: Cross-platform toolkit
- **Node.js 18+**: For development server and E2E testing
- **Python 3.8+**: For test server

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/twisted-brain/tb-pages.git
   cd tb-pages
   ```

2. **Install Haxe dependencies:**
   ```bash
   haxe --run tools.Setup
   ```

3. **Install Node.js dependencies:**
   ```bash
   npm install
   ```

## Build Instructions

### Development Build
```bash
# Build the application
haxe build.hxml

# Start development server
npm run serve
# Application available at http://localhost:8080
```

### Production Build
```bash
# Clean build
rm -rf build/
haxe build.hxml

# Verify build artifacts
ls -la build/
```

### Build Artifacts
After successful build, the following structure is created:
```
build/
├── assets/          # Image assets (logos, icons)
├── js/             # Compiled JavaScript
│   ├── app.js      # Main application
│   └── TwistedBrainApp.js
├── favicon.png     # Site favicon
├── index.html      # Main HTML file
└── styles.css      # Compiled styles
```

## Testing

### Unit Tests
```bash
# Run unit tests
haxe test.hxml

# Run tests in browser environment
python3 -m http.server 8001 --directory build/tests
# Open http://localhost:8001/test.html
```

### End-to-End Tests
```bash
# Install Playwright browsers (first time only)
npx playwright install

# Run E2E tests
npm run test:e2e

# Run E2E tests with UI
npx playwright test --ui
```

### Test Coverage
- **Domain Logic**: 80%+ coverage required
- **Adapters**: 70%+ coverage required
- **E2E Scenarios**: All critical user flows

## Development Workflow

### Code → Test → Fix → Deploy Cycle
1. **Code**: Implement features in domain-first architecture
2. **Test**: Run unit and integration tests
3. **Fix**: Address any failures or issues
4. **Deploy**: Build and verify in browser

### Architecture
```
/domain/           # Pure business logic (Haxe)
/shared/           # Target-agnostic utilities
/widgets/          # Reusable UI components
/platform/js/      # JavaScript-specific adapters
/tests/           # Comprehensive test suite
```

## Quality Gates

### Build Requirements
- ✅ **Compilation**: All targets compile without errors
- ✅ **Runtime**: Application starts and responds correctly
- ✅ **Assets**: All required assets load successfully
- ✅ **Styling**: CSS loads and renders properly

### Testing Requirements
- ✅ **Unit Tests**: Domain logic thoroughly tested
- ✅ **Integration**: Adapters tested per target
- ✅ **E2E**: Main user flows verified
- ✅ **Visual**: No regression in UI components

### Code Quality
- ✅ **Linting**: Code follows Haxe conventions
- ✅ **Dependencies**: All dependencies locked and secure
- ✅ **Documentation**: Inline comments for key functions
- ✅ **No Placeholders**: All TODO items resolved

## Acceptance Criteria

### Functional Requirements
- [x] Landing page loads without errors
- [x] All images and assets display correctly
- [x] Navigation and CTAs function properly
- [x] Animations and effects work smoothly
- [x] Responsive design across devices

### Technical Requirements
- [x] Haxe compilation succeeds for JavaScript target
- [x] Build artifacts generated in correct structure
- [x] Unit tests pass with required coverage
- [x] E2E tests verify critical user flows
- [x] No console errors in browser

### Performance Requirements
- [x] Page loads within 3 seconds
- [x] Assets optimized for web delivery
- [x] Smooth animations (60fps target)
- [x] Minimal bundle size

## Troubleshooting

### Common Issues

**Build Failures:**
- Ensure Haxe 4.3+ is installed
- Check that all dependencies are available
- Verify file paths are correct

**Asset Loading Issues:**
- Confirm assets exist in `/assets/` directory
- Check build output for copied files
- Verify server is serving from correct directory

**Test Failures:**
- Ensure browser environment for DOM-dependent tests
- Check that test server is running
- Verify Playwright browsers are installed

## Contributing

1. Fork the repository
2. Create a feature branch
3. Follow the development workflow
4. Ensure all quality gates pass
5. Submit a pull request

## License

MIT License - see LICENSE file for details.

## Built With

- **Haxe**: Cross-platform development toolkit
- **JavaScript**: Primary deployment target
- **CSS3**: Modern styling with neon effects
- **Playwright**: End-to-end testing framework
- **UTest**: Unit testing framework for Haxe

---

**Twisted Brain** - Bridging AI, code, and human creativity in DevOps workflows.
# TB-Pages - Twisted Brain AI GitHub Repository Viewer

A modern web application built with Haxe and React that displays GitHub repositories in a beautiful, responsive interface.

## Features

- **Modern UI**: Clean, dark-themed interface with gradient backgrounds
- **GitHub Integration**: Fetches and displays repository information via GitHub API
- **Responsive Design**: Works seamlessly across desktop and mobile devices
- **Real-time Data**: Live repository information including stars, language, and last update
- **Component Architecture**: Modular React components for maintainability

## Technology Stack

- **Frontend**: Haxe compiled to JavaScript
- **UI Framework**: React 18
- **Styling**: CSS3 with modern features (gradients, flexbox, grid)
- **Build Tool**: Webpack 5
- **Package Manager**: npm
- **API**: GitHub REST API v3

## Project Structure

```
tb-pages/
├── src/
│   ├── Main.hx                 # Application entry point
│   ├── components/             # React components
│   │   ├── App.hx             # Main application component
│   │   ├── Header.hx          # Header with title and subtitle
│   │   ├── RepoList.hx        # Repository list container
│   │   ├── RepoCard.hx        # Individual repository card
│   │   └── Footer.hx          # Footer with copyright info
│   ├── css/                   # Stylesheets and CSS abstractions
│   │   ├── App.css           # Main application styles
│   │   ├── Header.css        # Header component styles
│   │   ├── RepoList.css      # Repository list styles
│   │   ├── RepoCard.css      # Repository card styles
│   │   ├── Footer.css        # Footer component styles
│   │   └── *Css.hx           # Haxe CSS abstractions
│   └── services/
│       └── GitHubApiService.hx # GitHub API integration
├── platform/js/               # JavaScript platform files
├── assets/                    # Static assets and images
└── build/                     # Compiled output (generated)
```

## Installation

### Prerequisites

- Node.js (v16 or higher)
- npm (v8 or higher)
- Haxe (v4.3 or higher)
- lix (Haxe package manager)

### Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd tb-pages
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Install Haxe libraries**
   ```bash
   lix install haxe-react
   ```

## Development

### Start Development Server

```bash
npm start
```

This will:
- Start Webpack development server
- Enable hot module replacement
- Open the application at `http://localhost:9000`
- Watch for file changes and auto-reload

### Build for Production

```bash
npm run build
```

This creates an optimized production build in the `build/` directory.

## Configuration

### GitHub API

The application fetches repositories from the GitHub user "twistedbrain". To change this:

1. Open `src/components/RepoList.hx`
2. Modify the username in the `loadRepositories()` method:
   ```haxe
   GitHubApiService.getUserRepositories("your-username")
   ```

### Styling

The application uses a dark theme with blue accents. Colors can be customized in the respective CSS files:

- Primary background: `#0f1419`
- Secondary background: `#1a202c`
- Accent color: `#63b3ed`
- Text color: `#e2e8f0`

## API Integration

### GitHub API Service

The `GitHubApiService` provides methods to fetch repository data:

- `getUserRepositories(username)`: Fetch user repositories
- `getOrganizationRepositories(org)`: Fetch organization repositories

Both methods return promises with repository data including:
- Repository name and description
- Star count and primary language
- Last update timestamp
- Direct link to GitHub repository

## Components

### Header
Displays the application title and subtitle with gradient styling.

### RepoList
Manages repository data fetching and displays loading/error states. Renders repositories in a responsive grid layout.

### RepoCard
Individual repository display with:
- Repository name (linked to GitHub)
- Description
- Star count
- Primary programming language
- Last update date

### Footer
Simple footer with copyright and technology information.

## Browser Support

- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

## Known Issues

- ReactDOM.render deprecation warning (React 18 compatibility)
- CORS limitations may require GitHub API token for higher rate limits

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

Copyright © 2024 Twisted Brain AI - Haxe DevOps Project

---

**Built with ❤️ using Haxe and React**
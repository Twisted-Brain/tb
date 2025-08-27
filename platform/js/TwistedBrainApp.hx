package platform.js;

import domain.LandingPageService;
import shared.AssetManager;
import shared.AnimationUtils;
import js.Browser;
import js.html.Document;
import js.html.Element;

/**
 * Main application entry point for the Twisted Brain landing page.
 * Handles initialization, rendering, and user interactions for the JavaScript target.
 * 
 * This class serves as the platform adapter, bridging domain logic
 * with browser-specific implementations and DOM manipulation.
 */
class TwistedBrainApp {
    
    private var landingPageService: LandingPageService;
    private var assetManager: AssetManager;
    private var pageConfiguration: PageConfiguration;
    private var isInitialized: Bool = false;
    
    /**
     * Application entry point
     */
    public static function main(): Void {
        var app = new TwistedBrainApp();
        app.initialize();
    }
    
    /**
     * Initialize the application
     */
    public function new() {
        landingPageService = new LandingPageService();
        assetManager = AssetManager.getInstance();
    }
    
    /**
     * Initialize the application and start rendering
     */
    public function initialize(): Void {
        if (isInitialized) return;
        
        trace("Initializing Twisted Brain Landing Page...");
        
        // Wait for DOM to be ready
        if (Browser.document.readyState == "loading") {
            Browser.document.addEventListener("DOMContentLoaded", onDOMReady);
        } else {
            onDOMReady();
        }
    }
    
    /**
     * Handle DOM ready event
     */
    private function onDOMReady(): Void {
        pageConfiguration = landingPageService.getPageConfiguration();
        
        // Load critical assets first
        var criticalAssets = landingPageService.getCriticalAssetPaths();
        
        assetManager.preloadAssets(
            criticalAssets,
            onAssetsLoaded,
            onAssetLoadProgress
        );
    }
    
    /**
     * Handle asset loading progress
     */
    private function onAssetLoadProgress(loaded: Int, total: Int): Void {
        var progress = Math.round((loaded / total) * 100);
        trace('Asset loading progress: $progress% ($loaded/$total)');
        
        // Update loading indicator if present
        var loadingIndicator = Browser.document.getElementById("loading-progress");
        if (loadingIndicator != null) {
            loadingIndicator.textContent = 'Loading assets... $progress%';
        }
    }
    
    /**
     * Handle completion of asset loading
     */
    private function onAssetsLoaded(): Void {
        trace("Critical assets loaded. Rendering page...");
        
        // Hide loading indicator
        var loadingIndicator = Browser.document.getElementById("loading-indicator");
        if (loadingIndicator != null) {
            loadingIndicator.style.display = "none";
        }
        
        // Render the complete page
        renderPage();
        
        // Initialize interactions and animations
        initializeInteractions();
        
        // Mark as initialized
        isInitialized = true;
        
        trace("Twisted Brain Landing Page initialized successfully!");
    }
    
    /**
     * Render the complete landing page
     */
    private function renderPage(): Void {
        var body = Browser.document.body;
        
        // Clear existing content (except loading indicator)
        var loadingIndicator = Browser.document.getElementById("loading-indicator");
        body.innerHTML = "";
        if (loadingIndicator != null) {
            body.appendChild(loadingIndicator);
        }
        
        // Create main container
        var mainContainer = Browser.document.createDivElement();
        mainContainer.id = "twisted-brain-app";
        mainContainer.className = "app-container";
        
        // Render each section
        mainContainer.appendChild(renderHeroSection());
        mainContainer.appendChild(renderAboutSection());
        mainContainer.appendChild(renderFeaturesSection());
        mainContainer.appendChild(renderShowcaseSection());
        mainContainer.appendChild(renderCommunitySection());
        mainContainer.appendChild(renderFooterSection());
        
        body.appendChild(mainContainer);
        
        // Apply theme styles
        applyThemeStyles();
    }
    
    /**
     * Render hero section
     */
    private function renderHeroSection(): Element {
        var heroData = pageConfiguration.hero;
        
        var section = Browser.document.createElement("section");
        section.id = "hero";
        section.className = "hero-section neon-background";
        
        section.innerHTML = '
            <div class="hero-container">
                <div class="hero-content">
                    <div class="hero-logos">
                        <img src="${heroData.logoLeft}" alt="Twisted Brain Logo" class="logo-left neon-glow-cyan" />
                        <img src="${heroData.logoRight}" alt="Haxe DevOps Logo" class="logo-right neon-glow-orange" />
                    </div>
                    <h1 class="hero-headline neon-text-cyan">${heroData.headline}</h1>
                    <p class="hero-subtext">${heroData.subtext}</p>
                    <div class="hero-ctas">
                        <a href="${heroData.primaryCta.url}" class="cta-button ${heroData.primaryCta.style}">
                            ${heroData.primaryCta.text}
                        </a>
                        <a href="${heroData.secondaryCta.url}" class="cta-button ${heroData.secondaryCta.style}" target="_blank">
                            ${heroData.secondaryCta.text}
                        </a>
                    </div>
                </div>
                <div class="hero-background">
                    <svg class="circuit-lines" viewBox="0 0 1200 800">
                        <path class="circuit-path cyan" d="M0,400 Q300,200 600,400 T1200,400" />
                        <path class="circuit-path magenta" d="M0,300 Q400,100 800,300 T1200,300" />
                        <path class="circuit-path orange" d="M0,500 Q200,700 400,500 T800,500 Q1000,300 1200,500" />
                    </svg>
                </div>
            </div>
        ';
        
        return section;
    }
    
    /**
     * Render about section
     */
    private function renderAboutSection(): Element {
        var aboutData = pageConfiguration.about;
        
        var section = Browser.document.createElement("section");
        section.id = "about";
        section.className = "about-section";
        
        section.innerHTML = '
            <div class="section-container">
                <div class="about-content">
                    <div class="about-logo">
                        <img src="${aboutData.logo}" alt="Twisted Brain" class="neon-glow-magenta" />
                    </div>
                    <div class="about-text">
                        <h2 class="section-tagline neon-text-magenta">${aboutData.tagline}</h2>
                        <p class="about-description">${aboutData.description}</p>
                    </div>
                </div>
            </div>
        ';
        
        return section;
    }
    
    /**
     * Render features section
     */
    private function renderFeaturesSection(): Element {
        var featuresData = pageConfiguration.features;
        
        var section = Browser.document.createElement("section");
        section.id = "features";
        section.className = "features-section";
        
        var featuresHtml = '<div class="section-container"><h2 class="section-title neon-text-orange">Key Features</h2><div class="features-grid">';
        
        for (feature in featuresData) {
            featuresHtml += '
                <div class="feature-card neon-border-${feature.iconColor}">
                    <div class="feature-icon ${feature.icon} ${feature.iconColor}"></div>
                    <h3 class="feature-title">${feature.title}</h3>
                    <p class="feature-description">${feature.description}</p>
                </div>
            ';
        }
        
        featuresHtml += '</div></div>';
        section.innerHTML = featuresHtml;
        
        return section;
    }
    
    /**
     * Render showcase section
     */
    private function renderShowcaseSection(): Element {
        var showcaseData = pageConfiguration.showcase;
        
        var section = Browser.document.createElement("section");
        section.id = "showcase";
        section.className = "showcase-section";
        
        var mockupsHtml = '';
        for (mockup in showcaseData.mockups) {
            mockupsHtml += '
                <div class="mockup-item">
                    <div class="mockup-image neon-glow-blue">
                        <div class="mockup-placeholder">${mockup.platform}</div>
                    </div>
                    <p class="mockup-description">${mockup.description}</p>
                </div>
            ';
        }
        
        var cycleStepsHtml = '';
        for (i in 0...showcaseData.codeCycle.steps.length) {
            var step = showcaseData.codeCycle.steps[i];
            var isLast = i == showcaseData.codeCycle.steps.length - 1;
            cycleStepsHtml += '
                <div class="cycle-step">
                    <span class="step-text neon-text-cyan">${step}</span>
                    ${!isLast ? '<div class="step-arrow">→</div>' : ''}
                </div>
            ';
        }
        
        section.innerHTML = '
            <div class="section-container">
                <h2 class="section-title neon-text-blue">${showcaseData.title}</h2>
                <p class="section-description">${showcaseData.description}</p>
                
                <div class="mockups-container">
                    ${mockupsHtml}
                </div>
                
                <div class="code-cycle">
                    <h3 class="cycle-title">${showcaseData.codeCycle.description}</h3>
                    <div class="cycle-steps">
                        ${cycleStepsHtml}
                    </div>
                </div>
            </div>
        ';
        
        return section;
    }
    
    /**
     * Render community section
     */
    private function renderCommunitySection(): Element {
        var communityData = pageConfiguration.community;
        
        var section = Browser.document.createElement("section");
        section.id = "community";
        section.className = "community-section";
        
        var socialLinksHtml = '';
        for (link in communityData.socialLinks) {
            socialLinksHtml += '
                <a href="${link.url}" class="social-link neon-glow-cyan" target="_blank">
                    <span class="social-icon ${link.icon}"></span>
                    <span class="social-text">${link.platform}</span>
                </a>
            ';
        }
        
        section.innerHTML = '
            <div class="section-container">
                <h2 class="community-statement neon-text-magenta">${communityData.statement}</h2>
                <p class="community-description">${communityData.description}</p>
                
                <div class="community-actions">
                    <a href="${communityData.primaryCta.url}" class="cta-button ${communityData.primaryCta.style}" target="_blank">
                        ${communityData.primaryCta.text}
                    </a>
                </div>
                
                <div class="social-links">
                    ${socialLinksHtml}
                </div>
            </div>
        ';
        
        return section;
    }
    
    /**
     * Render footer section
     */
    private function renderFooterSection(): Element {
        var footerData = pageConfiguration.footer;
        
        var section = Browser.document.createElement("footer");
        section.id = "footer";
        section.className = "footer-section neon-border-top";
        
        var linksHtml = '';
        for (category in footerData.links) {
            linksHtml += '<div class="link-category">';
            linksHtml += '<h4 class="category-title neon-text-cyan">${category.category}</h4>';
            linksHtml += '<ul class="category-links">';
            
            for (link in category.items) {
                linksHtml += '<li><a href="${link.url}" class="footer-link">${link.text}</a></li>';
            }
            
            linksHtml += '</ul></div>';
        }
        
        section.innerHTML = '
            <div class="footer-container">
                <div class="footer-content">
                    <div class="footer-branding">
                        <img src="${footerData.logo}" alt="Twisted Brain" class="footer-logo neon-glow-magenta" />
                        <img src="${footerData.devOpsLogo}" alt="Haxe DevOps" class="devops-logo neon-glow-orange" />
                    </div>
                    
                    <div class="footer-links">
                        ${linksHtml}
                    </div>
                </div>
                
                <div class="footer-bottom">
                    <p class="copyright">${footerData.copyright}</p>
                    <p class="haxe-credit neon-text-orange">${footerData.haxeCredit}</p>
                </div>
            </div>
        ';
        
        return section;
    }
    
    /**
     * Apply theme styles to the page
     */
    private function applyThemeStyles(): Void {
        var theme = pageConfiguration.theme;
        
        // Create and inject CSS styles
        var styleElement = Browser.document.createStyleElement();
        styleElement.textContent = generateThemeCSS(theme);
        Browser.document.head.appendChild(styleElement);
    }
    
    /**
     * Generate CSS from theme configuration
     */
    private function generateThemeCSS(theme: ThemeConfiguration): String {
        return '
            /* Twisted Brain Landing Page Styles */
            @import url("https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Inter:wght@300;400;500;600&family=Fira+Code:wght@300;400;500&display=swap");
            
            :root {
                --color-cyan: ${theme.colorPalette.primary.cyan};
                --color-magenta: ${theme.colorPalette.primary.magenta};
                --color-orange: ${theme.colorPalette.primary.orange};
                --color-blue: ${theme.colorPalette.primary.blue};
                --color-dark: ${theme.colorPalette.background.dark};
                --color-dark-gray: ${theme.colorPalette.background.darkGray};
                --color-medium-gray: ${theme.colorPalette.background.mediumGray};
                --glow-cyan: ${theme.colorPalette.accent.neonGlow};
                --glow-purple: ${theme.colorPalette.accent.purpleGlow};
                --glow-orange: ${theme.colorPalette.accent.orangeGlow};
                --font-heading: ${theme.typography.headingFont};
                --font-body: ${theme.typography.bodyFont};
                --font-code: ${theme.typography.codeFont};
            }
            
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: var(--font-body);
                background: var(--color-dark);
                color: #ffffff;
                line-height: 1.6;
                overflow-x: hidden;
            }
            
            .app-container {
                min-height: 100vh;
            }
            
            /* Neon text effects */
            .neon-text-cyan {
                color: var(--color-cyan);
                text-shadow: 0 0 10px var(--glow-cyan), 0 0 20px var(--glow-cyan);
            }
            
            .neon-text-magenta {
                color: var(--color-magenta);
                text-shadow: 0 0 10px var(--glow-purple), 0 0 20px var(--glow-purple);
            }
            
            .neon-text-orange {
                color: var(--color-orange);
                text-shadow: 0 0 10px var(--glow-orange), 0 0 20px var(--glow-orange);
            }
            
            .neon-text-blue {
                color: var(--color-blue);
                text-shadow: 0 0 10px var(--color-blue), 0 0 20px var(--color-blue);
            }
            
            /* Neon glow effects */
            .neon-glow-cyan {
                box-shadow: 0 0 15px var(--glow-cyan), 0 0 25px var(--glow-cyan);
            }
            
            .neon-glow-magenta {
                box-shadow: 0 0 15px var(--glow-purple), 0 0 25px var(--glow-purple);
            }
            
            .neon-glow-orange {
                box-shadow: 0 0 15px var(--glow-orange), 0 0 25px var(--glow-orange);
            }
            
            .neon-glow-blue {
                box-shadow: 0 0 15px var(--color-blue), 0 0 25px var(--color-blue);
            }
            
            /* Hero Section */
            .hero-section {
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                background: linear-gradient(135deg, var(--color-dark) 0%, var(--color-dark-gray) 100%);
            }
            
            .hero-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 2rem;
                text-align: center;
                position: relative;
                z-index: 2;
            }
            
            .hero-logos {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 4rem;
                margin-bottom: 3rem;
            }
            
            .logo-left, .logo-right {
                height: 120px;
                width: auto;
                transition: transform 0.3s ease;
            }
            
            .logo-left:hover, .logo-right:hover {
                transform: scale(1.1);
            }
            
            .hero-headline {
                font-family: var(--font-heading);
                font-size: 4rem;
                font-weight: 900;
                margin-bottom: 1.5rem;
                animation: ${theme.effects.pulseAnimation};
            }
            
            .hero-subtext {
                font-size: 1.25rem;
                max-width: 800px;
                margin: 0 auto 3rem;
                color: #cccccc;
                line-height: 1.8;
            }
            
            .hero-ctas {
                display: flex;
                gap: 2rem;
                justify-content: center;
                flex-wrap: wrap;
            }
            
            /* CTA Buttons */
            .cta-button {
                display: inline-block;
                padding: 1rem 2.5rem;
                font-family: var(--font-heading);
                font-weight: 700;
                text-decoration: none;
                border-radius: 8px;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            
            .primary-neon {
                background: linear-gradient(45deg, var(--color-cyan), var(--color-blue));
                color: var(--color-dark);
                box-shadow: 0 0 20px var(--glow-cyan);
            }
            
            .primary-neon:hover {
                transform: translateY(-2px);
                box-shadow: 0 0 30px var(--glow-cyan), 0 5px 15px rgba(0, 255, 255, 0.3);
            }
            
            .secondary-outline {
                background: transparent;
                color: var(--color-cyan);
                border: 2px solid var(--color-cyan);
                box-shadow: 0 0 15px var(--glow-cyan);
            }
            
            .secondary-outline:hover {
                background: var(--glow-cyan);
                color: var(--color-dark);
                transform: translateY(-2px);
            }
            
            /* Circuit Background */
            .hero-background {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: 1;
                opacity: 0.3;
            }
            
            .circuit-lines {
                width: 100%;
                height: 100%;
            }
            
            .circuit-path {
                fill: none;
                stroke-width: 2;
                animation: ${theme.effects.circuitAnimation};
            }
            
            .circuit-path.cyan {
                stroke: var(--color-cyan);
                filter: drop-shadow(0 0 5px var(--glow-cyan));
            }
            
            .circuit-path.magenta {
                stroke: var(--color-magenta);
                filter: drop-shadow(0 0 5px var(--glow-purple));
            }
            
            .circuit-path.orange {
                stroke: var(--color-orange);
                filter: drop-shadow(0 0 5px var(--glow-orange));
            }
            
            /* Section Containers */
            .section-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 5rem 2rem;
            }
            
            .section-title {
                font-family: var(--font-heading);
                font-size: 3rem;
                text-align: center;
                margin-bottom: 3rem;
            }
            
            .section-description {
                font-size: 1.2rem;
                text-align: center;
                max-width: 800px;
                margin: 0 auto 4rem;
                color: #cccccc;
            }
            
            /* About Section */
            .about-section {
                background: var(--color-dark-gray);
            }
            
            .about-content {
                display: grid;
                grid-template-columns: 1fr 2fr;
                gap: 4rem;
                align-items: center;
            }
            
            .about-logo img {
                width: 100%;
                max-width: 300px;
                height: auto;
            }
            
            .section-tagline {
                font-family: var(--font-heading);
                font-size: 2rem;
                margin-bottom: 2rem;
            }
            
            .about-description {
                font-size: 1.1rem;
                line-height: 1.8;
                color: #cccccc;
            }
            
            /* Features Section */
            .features-section {
                background: var(--color-dark);
            }
            
            .features-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
                gap: 3rem;
            }
            
            .feature-card {
                background: var(--color-dark-gray);
                padding: 3rem 2rem;
                border-radius: 12px;
                text-align: center;
                border: 1px solid transparent;
                transition: all 0.3s ease;
            }
            
            .feature-card:hover {
                transform: translateY(-5px);
            }
            
            .neon-border-cyan-magenta {
                border-color: var(--color-cyan);
                box-shadow: 0 0 20px var(--glow-cyan);
            }
            
            .neon-border-orange-glow {
                border-color: var(--color-orange);
                box-shadow: 0 0 20px var(--glow-orange);
            }
            
            .neon-border-purple-cyan {
                border-color: var(--color-magenta);
                box-shadow: 0 0 20px var(--glow-purple);
            }
            
            .feature-icon {
                width: 80px;
                height: 80px;
                margin: 0 auto 2rem;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2rem;
            }
            
            .feature-title {
                font-family: var(--font-heading);
                font-size: 1.5rem;
                margin-bottom: 1rem;
                color: #ffffff;
            }
            
            .feature-description {
                color: #cccccc;
                line-height: 1.6;
            }
            
            /* Responsive Design */
            @media (max-width: 768px) {
                .hero-headline {
                    font-size: 2.5rem;
                }
                
                .hero-logos {
                    gap: 2rem;
                }
                
                .logo-left, .logo-right {
                    height: 80px;
                }
                
                .about-content {
                    grid-template-columns: 1fr;
                    text-align: center;
                }
                
                .hero-ctas {
                    flex-direction: column;
                    align-items: center;
                }
                
                .features-grid {
                    grid-template-columns: 1fr;
                }
            }
            
            /* Animations */
            @keyframes pulse {
                0% { opacity: 1; }
                50% { opacity: 0.8; }
                100% { opacity: 1; }
            }
            
            @keyframes circuit-flow {
                0% { stroke-dashoffset: 0; }
                100% { stroke-dashoffset: -50; }
            }
        ';
    }
    
    /**
     * Initialize interactions and animations
     */
    private function initializeInteractions(): Void {
        // Add smooth scrolling for internal links
        initializeSmoothScrolling();
        
        // Initialize neon animations
        initializeNeonAnimations();
        
        // Initialize scroll-triggered animations
        initializeScrollAnimations();
        
        // Initialize hover effects
        initializeHoverEffects();
    }
    
    /**
     * Initialize smooth scrolling for navigation
     */
    private function initializeSmoothScrolling(): Void {
        var links = Browser.document.querySelectorAll('a[href^="#"]');
        
        for (i in 0...links.length) {
            var link = cast(links[i], js.html.AnchorElement);
            link.addEventListener("click", function(e) {
                e.preventDefault();
                var targetId = link.getAttribute("href").substring(1);
                var targetElement = Browser.document.getElementById(targetId);
                
                if (targetElement != null) {
                    targetElement.scrollIntoView({
                    behavior: js.html.ScrollBehavior.SMOOTH,
                    block: js.html.ScrollLogicalPosition.START
                });
                }
            });
        }
    }
    
    /**
     * Initialize neon glow animations
     */
    private function initializeNeonAnimations(): Void {
        // Pulse animation for hero headline
        var heroHeadline = Browser.document.querySelector(".hero-headline");
        if (heroHeadline != null) {
            AnimationUtils.createNeonPulse(heroHeadline, "#00FFFF", 3.0, 1.2);
        }
        
        // Circuit flow animations
        var circuitPaths = Browser.document.querySelectorAll(".circuit-path");
        for (i in 0...circuitPaths.length) {
            AnimationUtils.createCircuitFlow(circuitPaths[i], 8.0 + (i * 2));
        }
    }
    
    /**
     * Initialize scroll-triggered animations
     */
    private function initializeScrollAnimations(): Void {
        var featureCards = Browser.document.querySelectorAll(".feature-card");
        
        AnimationUtils.createStaggeredAnimation(
            [for (i in 0...featureCards.length) featureCards[i]],
            function(element) {
                AnimationUtils.createScrollAnimation(element, function(el) {
                    cast(el, js.html.Element).style.opacity = "1";
                    cast(el, js.html.Element).style.transform = "translateY(0)";
                });
            },
            0.2
        );
    }
    
    /**
     * Initialize hover effects for interactive elements
     */
    private function initializeHoverEffects(): Void {
        // CTA button hover effects
        var ctaButtons = Browser.document.querySelectorAll(".cta-button");
        for (i in 0...ctaButtons.length) {
            var button = cast(ctaButtons[i], js.html.Element);
            
            if (button.classList.contains("primary-neon")) {
                AnimationUtils.createHoverGlow(
                    button,
                    {color: "#00FFFF", blur: 20.0, spread: 30.0, textBlur: 0.0},
                    {color: "#00FFFF", blur: 30.0, spread: 40.0, textBlur: 0.0}
                );
            }
        }
        
        // Logo hover effects
        var logos = Browser.document.querySelectorAll(".logo-left, .logo-right");
        for (i in 0...logos.length) {
            var logo = cast(logos[i], js.html.Element);
            AnimationUtils.createFloatingAnimation(logo, 10.0, 4.0);
        }
    }
}
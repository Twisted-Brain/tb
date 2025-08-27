package domain;

import domain.LandingPageData;
import domain.LandingPageData.HeroSectionConfig;
import domain.LandingPageData.AboutSectionConfig;
import domain.LandingPageData.FeatureConfig;
import domain.LandingPageData.ShowcaseSectionConfig;
import domain.LandingPageData.CommunitySectionConfig;
import domain.LandingPageData.FooterSectionConfig;

/**
 * Business logic service for the Twisted Brain landing page.
 * Handles data processing, validation, and business rules.
 * 
 * This service acts as the core business layer, implementing
 * domain-specific operations while remaining platform-agnostic.
 */
class LandingPageService {
    
    private var pageData: LandingPageData;
    
    /**
     * Initialize the landing page service
     */
    public function new() {
        // LandingPageData is a static class, no instantiation needed
    }
    
    /**
     * Get complete page configuration for rendering
     * @return Complete page configuration object
     */
    public function getPageConfiguration(): PageConfiguration {
        return {
            hero: LandingPageData.getHeroSectionData(),
            about: LandingPageData.getAboutSectionData(),
            features: LandingPageData.getFeaturesSectionData(),
            showcase: LandingPageData.getShowcaseSectionData(),
            community: LandingPageData.getCommunitySectionData(),
            footer: LandingPageData.getFooterSectionData(),
            theme: getThemeConfiguration(),
            metadata: getPageMetadata()
        };
    }
    
    /**
     * Get theme configuration for neon-glow aesthetic
     * @return Theme configuration with color palette and styles
     */
    public function getThemeConfiguration(): ThemeConfiguration {
        return {
            colorPalette: {
                primary: {
                    cyan: "#00FFFF",
                    magenta: "#FF00FF",
                    orange: "#FF8C00",
                    blue: "#0080FF"
                },
                background: {
                    dark: "#0A0A0A",
                    darkGray: "#1A1A1A",
                    mediumGray: "#2A2A2A"
                },
                accent: {
                    neonGlow: "rgba(0, 255, 255, 0.8)",
                    purpleGlow: "rgba(255, 0, 255, 0.6)",
                    orangeGlow: "rgba(255, 140, 0, 0.7)"
                }
            },
            typography: {
                headingFont: "'Orbitron', monospace",
                bodyFont: "'Inter', sans-serif",
                codeFont: "'Fira Code', monospace"
            },
            effects: {
                glowIntensity: "0 0 20px",
                pulseAnimation: "pulse 2s ease-in-out infinite alternate",
                circuitAnimation: "circuit-flow 10s linear infinite"
            }
        };
    }
    
    /**
     * Get page metadata for SEO and social sharing
     * @return Page metadata configuration
     */
    public function getPageMetadata(): PageMetadata {
        return {
            title: "Twisted Brain - AI + Human DevOps with Haxe",
            description: "Experience the future of DevOps with AI-assisted Haxe development. Build once, deploy everywhere with intelligent automation and human creativity.",
            keywords: ["Haxe", "AI", "DevOps", "Cross-platform", "Development", "Automation", "Neon", "Futuristic"],
            author: "Twisted Brain Team",
            ogImage: "assets/tb_3.png",
            twitterCard: "summary_large_image",
            canonicalUrl: "https://twisted-brain.github.io/tb-pages/",
            language: "en-US"
        };
    }
    
    /**
     * Validate section configuration for completeness
     * @param sectionType The type of section to validate
     * @return Validation result with any issues found
     */
    public function validateSectionConfiguration(sectionType: String): ValidationResult {
        var issues: Array<String> = [];
        
        switch (sectionType) {
            case "hero":
                var heroData = LandingPageData.getHeroSectionData();
                if (heroData.headline == null || heroData.headline.length == 0) {
                    issues.push("Hero headline is required");
                }
                if (heroData.primaryCta == null || heroData.primaryCta.text == null) {
                    issues.push("Hero primary CTA is required");
                }
                
            case "features":
                var featuresData = LandingPageData.getFeaturesSectionData();
                if (featuresData.length != 3) {
                    issues.push("Features section must have exactly 3 features");
                }
                for (feature in featuresData) {
                    if (feature.title == null || feature.title.length == 0) {
                        issues.push("Feature title is required");
                    }
                }
                
            case "community":
                var communityData = LandingPageData.getCommunitySectionData();
                if (communityData.primaryCta == null || communityData.primaryCta.url == null) {
                    issues.push("Community CTA URL is required");
                }
                
            default:
                issues.push("Unknown section type: " + sectionType);
        }
        
        return {
            isValid: issues.length == 0,
            issues: issues
        };
    }
    
    /**
     * Get asset paths for preloading critical resources
     * @return Array of asset paths that should be preloaded
     */
    public function getCriticalAssetPaths(): Array<String> {
        var assets: Array<String> = [];
        
        // Hero section assets
        var heroData = LandingPageData.getHeroSectionData();
        assets.push(heroData.logo);
        
        // About section assets
        var aboutData = LandingPageData.getAboutSectionData();
        assets.push(aboutData.logo);
        
        // Footer assets
        var footerData = LandingPageData.getFooterSectionData();
        assets.push(footerData.logo);
        assets.push(footerData.devOpsLogo);
        
        return assets;
    }
    
    /**
     * Generate navigation structure for smooth scrolling
     * @return Navigation configuration for internal links
     */
    public function getNavigationStructure(): NavigationStructure {
        return {
            sections: [
                {id: "hero", label: "Home", order: 1},
                {id: "about", label: "About", order: 2},
                {id: "features", label: "Features", order: 3},
                {id: "showcase", label: "Showcase", order: 4},
                {id: "community", label: "Community", order: 5}
            ],
            scrollBehavior: "smooth",
            offsetTop: 80 // Account for fixed header
        };
    }
}

// Additional type definitions for service layer
typedef PageConfiguration = {
    hero: HeroSectionConfig,
    about: AboutSectionConfig,
    features: Array<FeatureConfig>,
    showcase: ShowcaseSectionConfig,
    community: CommunitySectionConfig,
    footer: FooterSectionConfig,
    theme: ThemeConfiguration,
    metadata: PageMetadata
}

typedef ThemeConfiguration = {
    colorPalette: ColorPalette,
    typography: Typography,
    effects: Effects
}

typedef ColorPalette = {
    primary: PrimaryColors,
    background: BackgroundColors,
    accent: AccentColors
}

typedef PrimaryColors = {
    cyan: String,
    magenta: String,
    orange: String,
    blue: String
}

typedef BackgroundColors = {
    dark: String,
    darkGray: String,
    mediumGray: String
}

typedef AccentColors = {
    neonGlow: String,
    purpleGlow: String,
    orangeGlow: String
}

typedef Typography = {
    headingFont: String,
    bodyFont: String,
    codeFont: String
}

typedef Effects = {
    glowIntensity: String,
    pulseAnimation: String,
    circuitAnimation: String
}

typedef PageMetadata = {
    title: String,
    description: String,
    keywords: Array<String>,
    author: String,
    ogImage: String,
    twitterCard: String,
    canonicalUrl: String,
    language: String
}

typedef ValidationResult = {
    isValid: Bool,
    issues: Array<String>
}

typedef NavigationStructure = {
    sections: Array<NavigationSection>,
    scrollBehavior: String,
    offsetTop: Int
}

typedef NavigationSection = {
    id: String,
    label: String,
    order: Int
}
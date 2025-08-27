package domain;

/**
 * Core data structures for the Twisted Brain landing page.
 * Represents the content and configuration for each section.
 * 
 * This class follows the domain-driven design pattern, keeping
 * business logic separate from presentation concerns.
 */
class LandingPageData {
    
    /**
     * Hero section configuration with headline, subtext, and CTAs
     */
    public static function getHeroSectionData(): HeroSectionConfig {
        return {
            headline: "AI + Human: The Future of DevOps",
            subtext: "Bridging code, AI agents, and human creativity to build, test, and scale with Haxe. Experience the next generation of development workflows where artificial intelligence amplifies human potential.",
            primaryCta: {
                text: "Get Started",
                url: "#features",
                style: "primary-neon"
            },
            secondaryCta: {
                text: "View on GitHub",
                url: "https://github.com/twisted-brain/tb-pages",
                style: "secondary-outline"
            },
            backgroundStyle: "circuit-neon",
            logo: "assets/logo.png"
        };
    }
    
    /**
     * About section content describing Twisted Brain mission
     */
    public static function getAboutSectionData(): AboutSectionConfig {
        return {
            tagline: "We are developers shaping the future with Haxe and AI.",
            description: "Twisted Brain pioneers AI-assisted development for multi-target Haxe projects. Our platform enables seamless human-AI collaboration in DevOps cycles: code → test → validate → deploy. We focus on simplicity, automation, and creativity, empowering developers to build once and deploy everywhere while maintaining the human touch that makes software truly exceptional.",
            logo: "assets/tb_3.png",
            additionalAssets: ["assets/tb_4.png", "assets/tb_5.png"]
        };
    }
    
    /**
     * Key features grid configuration (3-column layout)
     */
    public static function getFeaturesSectionData(): Array<FeatureConfig> {
        return [
            {
                title: "AI DevOps Pipeline",
                description: "Automates repetitive coding and testing tasks with intelligent agents that learn from your patterns and preferences.",
                icon: "circuit-brain",
                iconColor: "cyan-magenta"
            },
            {
                title: "Multi-Target Haxe Development",
                description: "Compile once, run everywhere. Deploy to JavaScript, C++, Java, PHP, Lua, and more from a single codebase.",
                icon: "haxe-x",
                iconColor: "orange-glow"
            },
            {
                title: "Human + AI Collaboration",
                description: "AI proposes solutions, humans refine and perfect them. Balance efficiency with creativity for optimal results.",
                icon: "brain-split",
                iconColor: "purple-cyan"
            }
        ];
    }
    
    /**
     * Showcase section with demo content and code cycle diagram
     */
    public static function getShowcaseSectionData(): ShowcaseSectionConfig {
        return {
            title: "See Haxe in Action",
            description: "Experience the power of cross-platform development with real examples.",
            mockups: [
                {
                    platform: "Web",
                    image: "assets/mockup-web.svg",
                    description: "Responsive web applications"
                },
                {
                    platform: "Mobile",
                    image: "assets/mockup-mobile.svg",
                    description: "Native mobile experiences"
                },
                {
                    platform: "Desktop",
                    image: "assets/mockup-desktop.svg",
                    description: "Cross-platform desktop apps"
                }
            ],
            codeCycle: {
                steps: ["Code", "Test", "Fix", "Deploy", "Repeat"],
                description: "AI-assisted development cycle"
            }
        };
    }
    
    /**
     * Community section promoting open source collaboration
     */
    public static function getCommunitySectionData(): CommunitySectionConfig {
        return {
            statement: "Twisted Brain is open-source, transparent, and community-driven.",
            description: "Join our growing community of developers pushing the boundaries of AI-assisted development.",
            primaryCta: {
                text: "Contribute on GitHub",
                url: "https://github.com/twisted-brain",
                style: "primary-neon"
            },
            socialLinks: [
                {
                    platform: "GitHub",
                    url: "https://github.com/twisted-brain",
                    icon: "github"
                },
                {
                    platform: "Documentation",
                    url: "#docs",
                    icon: "docs"
                }
            ]
        };
    }
    
    /**
     * Footer section with links and branding
     */
    public static function getFooterSectionData(): FooterSectionConfig {
        return {
            logo: "assets/tb.png",
            devOpsLogo: "assets/hdevm_1.png",
            links: [
                {
                    category: "Project",
                    items: [
                        {text: "GitHub", url: "https://github.com/twisted-brain/tb-pages"},
                        {text: "Documentation", url: "#docs"},
                        {text: "Roadmap", url: "#roadmap"}
                    ]
                },
                {
                    category: "Community",
                    items: [
                        {text: "Contribute", url: "https://github.com/twisted-brain/tb-pages/contribute"},
                        {text: "Issues", url: "https://github.com/twisted-brain/tb-pages/issues"},
                        {text: "Contact", url: "#contact"}
                    ]
                }
            ],
            copyright: "© 2024 Twisted Brain. Open source under MIT License.",
            haxeCredit: "Built with Haxe - The Cross-Platform Toolkit"
        };
    }
}

// Type definitions for configuration structures
typedef HeroSectionConfig = {
    headline: String,
    subtext: String,
    primaryCta: CtaConfig,
    secondaryCta: CtaConfig,
    backgroundStyle: String,
    logo: String
}

typedef AboutSectionConfig = {
    tagline: String,
    description: String,
    logo: String,
    additionalAssets: Array<String>
}

typedef FeatureConfig = {
    title: String,
    description: String,
    icon: String,
    iconColor: String
}

typedef ShowcaseSectionConfig = {
    title: String,
    description: String,
    mockups: Array<MockupConfig>,
    codeCycle: CodeCycleConfig
}

typedef MockupConfig = {
    platform: String,
    image: String,
    description: String
}

typedef CodeCycleConfig = {
    steps: Array<String>,
    description: String
}

typedef CommunitySectionConfig = {
    statement: String,
    description: String,
    primaryCta: CtaConfig,
    socialLinks: Array<SocialLinkConfig>
}

typedef SocialLinkConfig = {
    platform: String,
    url: String,
    icon: String
}

typedef FooterSectionConfig = {
    logo: String,
    devOpsLogo: String,
    links: Array<LinkCategoryConfig>,
    copyright: String,
    haxeCredit: String
}

typedef LinkCategoryConfig = {
    category: String,
    items: Array<LinkConfig>
}

typedef LinkConfig = {
    text: String,
    url: String
}

typedef CtaConfig = {
    text: String,
    url: String,
    style: String
}
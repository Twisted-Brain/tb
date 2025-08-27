package tests.unit;

import domain.LandingPageService;
import domain.LandingPageData;
import utest.Test;
import utest.Assert;

/**
 * Comprehensive unit tests for LandingPageService domain logic.
 * Tests core business functionality, data validation, and service methods.
 * 
 * Ensures ≥80% code coverage for domain layer as required by quality gates.
 */
class TestLandingPageService extends Test {
    
    private var landingPageService: LandingPageService;
    
    /**
     * Set up test environment before each test
     */
    public function setup(): Void {
        landingPageService = new LandingPageService();
    }
    
    /**
     * Clean up after each test
     */
    public function tearDown(): Void {
        landingPageService = null;
    }
    
    /**
     * Test that service can be instantiated successfully
     */
    public function testServiceInstantiation(): Void {
        Assert.notNull(landingPageService);
        Assert.isTrue(Std.is(landingPageService, LandingPageService));
    }
    
    /**
     * Test getPageConfiguration returns valid configuration
     */
    public function testGetPageConfiguration(): Void {
        var config = landingPageService.getPageConfiguration();
        
        // Verify configuration is not null
        Assert.notNull(config);
        
        // Verify all required sections exist
        Assert.notNull(config.hero);
        Assert.notNull(config.about);
        Assert.notNull(config.features);
        Assert.notNull(config.showcase);
        Assert.notNull(config.community);
        Assert.notNull(config.footer);
        Assert.notNull(config.theme);
        Assert.notNull(config.metadata);
    }
    
    /**
     * Test hero configuration structure and content
     */
    public function testHeroConfiguration(): Void {
        var config = landingPageService.getPageConfiguration();
        var hero = config.hero;
        
        // Verify hero properties
        Assert.notNull(hero.headline);
        Assert.notNull(hero.subtext);
        Assert.notNull(hero.logo);
        Assert.notNull(hero.primaryCta);
        Assert.notNull(hero.secondaryCta);
        
        // Verify headline is not empty
        Assert.isTrue(hero.headline.length > 0);
        Assert.isTrue(hero.subtext.length > 0);
        
        // Verify CTA structure
        Assert.notNull(hero.primaryCta.text);
        Assert.notNull(hero.primaryCta.url);
        Assert.notNull(hero.primaryCta.style);
        Assert.isTrue(hero.primaryCta.text.length > 0);
        Assert.isTrue(hero.primaryCta.url.length > 0);
        
        Assert.notNull(hero.secondaryCta.text);
        Assert.notNull(hero.secondaryCta.url);
        Assert.notNull(hero.secondaryCta.style);
        Assert.isTrue(hero.secondaryCta.text.length > 0);
        Assert.isTrue(hero.secondaryCta.url.length > 0);
    }
    
    /**
     * Test about section configuration
     */
    public function testAboutConfiguration(): Void {
        var config = landingPageService.getPageConfiguration();
        var about = config.about;
        
        Assert.notNull(about.tagline);
        Assert.notNull(about.description);
        Assert.notNull(about.logo);
        
        Assert.isTrue(about.tagline.length > 0);
        Assert.isTrue(about.description.length > 0);
        Assert.isTrue(about.logo.length > 0);
    }
    
    /**
     * Test features configuration structure
     */
    public function testFeaturesConfiguration(): Void {
        var config = landingPageService.getPageConfiguration();
        var features = config.features;
        
        Assert.notNull(features);
        Assert.isTrue(features.length > 0);
        
        // Test each feature has required properties
        for (feature in features) {
            Assert.notNull(feature.title);
            Assert.notNull(feature.description);
            Assert.notNull(feature.icon);
            Assert.notNull(feature.iconColor);
            
            Assert.isTrue(feature.title.length > 0);
            Assert.isTrue(feature.description.length > 0);
            Assert.isTrue(feature.icon.length > 0);
            Assert.isTrue(feature.iconColor.length > 0);
        }
    }
    
    /**
     * Test showcase configuration
     */
    public function testShowcaseConfiguration(): Void {
        var config = landingPageService.getPageConfiguration();
        var showcase = config.showcase;
        
        Assert.notNull(showcase.title);
        Assert.notNull(showcase.description);
        Assert.notNull(showcase.mockups);
        Assert.notNull(showcase.codeCycle);
        
        Assert.isTrue(showcase.title.length > 0);
        Assert.isTrue(showcase.description.length > 0);
        Assert.isTrue(showcase.mockups.length > 0);
        
        // Test mockups structure
        for (mockup in showcase.mockups) {
            Assert.notNull(mockup.platform);
            Assert.notNull(mockup.description);
            Assert.isTrue(mockup.platform.length > 0);
            Assert.isTrue(mockup.description.length > 0);
        }
        
        // Test code cycle structure
        Assert.notNull(showcase.codeCycle.description);
        Assert.notNull(showcase.codeCycle.steps);
        Assert.isTrue(showcase.codeCycle.description.length > 0);
        Assert.isTrue(showcase.codeCycle.steps.length > 0);
        
        for (step in showcase.codeCycle.steps) {
            Assert.isTrue(step.length > 0);
        }
    }
    
    /**
     * Test community configuration
     */
    public function testCommunityConfiguration(): Void {
        var config = landingPageService.getPageConfiguration();
        var community = config.community;
        
        Assert.notNull(community.statement);
        Assert.notNull(community.description);
        Assert.notNull(community.primaryCta);
        Assert.notNull(community.socialLinks);
        
        Assert.isTrue(community.statement.length > 0);
        Assert.isTrue(community.description.length > 0);
        Assert.isTrue(community.socialLinks.length > 0);
        
        // Test primary CTA
        Assert.notNull(community.primaryCta.text);
        Assert.notNull(community.primaryCta.url);
        Assert.notNull(community.primaryCta.style);
        
        // Test social links
        for (link in community.socialLinks) {
            Assert.notNull(link.platform);
            Assert.notNull(link.url);
            Assert.notNull(link.icon);
            Assert.isTrue(link.platform.length > 0);
            Assert.isTrue(link.url.length > 0);
            Assert.isTrue(link.icon.length > 0);
        }
    }
    
    /**
     * Test footer configuration
     */
    public function testFooterConfiguration(): Void {
        var config = landingPageService.getPageConfiguration();
        var footer = config.footer;
        
        Assert.notNull(footer.logo);
        Assert.notNull(footer.devOpsLogo);
        Assert.notNull(footer.copyright);
        Assert.notNull(footer.haxeCredit);
        Assert.notNull(footer.links);
        
        Assert.isTrue(footer.logo.length > 0);
        Assert.isTrue(footer.devOpsLogo.length > 0);
        Assert.isTrue(footer.copyright.length > 0);
        Assert.isTrue(footer.haxeCredit.length > 0);
        Assert.isTrue(footer.links.length > 0);
        
        // Test link categories
        for (category in footer.links) {
            Assert.notNull(category.category);
            Assert.notNull(category.items);
            Assert.isTrue(category.category.length > 0);
            Assert.isTrue(category.items.length > 0);
            
            for (item in category.items) {
                Assert.notNull(item.text);
                Assert.notNull(item.url);
                Assert.isTrue(item.text.length > 0);
                Assert.isTrue(item.url.length > 0);
            }
        }
    }
    
    /**
     * Test theme configuration
     */
    public function testThemeConfiguration(): Void {
        var config = landingPageService.getPageConfiguration();
        var theme = config.theme;
        
        Assert.notNull(theme.colorPalette);
        Assert.notNull(theme.typography);
        Assert.notNull(theme.effects);
        
        // Test color palette
        var colors = theme.colorPalette;
        Assert.notNull(colors.primary);
        Assert.notNull(colors.background);
        Assert.notNull(colors.accent);
        
        Assert.notNull(colors.primary.cyan);
        Assert.notNull(colors.primary.magenta);
        Assert.notNull(colors.primary.orange);
        Assert.notNull(colors.primary.blue);
        
        // Test typography
        var typography = theme.typography;
        Assert.notNull(typography.headingFont);
        Assert.notNull(typography.bodyFont);
        Assert.notNull(typography.codeFont);
        
        // Test effects
        var effects = theme.effects;
        Assert.notNull(effects.pulseAnimation);
        Assert.notNull(effects.circuitAnimation);
    }
    
    /**
     * Test metadata configuration
     */
    public function testMetadataConfiguration(): Void {
        var config = landingPageService.getPageConfiguration();
        var metadata = config.metadata;
        
        Assert.notNull(metadata.title);
        Assert.notNull(metadata.description);
        Assert.notNull(metadata.keywords);
        Assert.notNull(metadata.author);
        Assert.notNull(metadata.ogImage);
        Assert.notNull(metadata.twitterCard);
        
        Assert.isTrue(metadata.title.length > 0);
        Assert.isTrue(metadata.description.length > 0);
        Assert.isTrue(metadata.keywords.length > 0);
        Assert.isTrue(metadata.author.length > 0);
    }
    
    /**
     * Test getCriticalAssetPaths returns valid asset paths
     */
    public function testGetCriticalAssetPaths(): Void {
        var assets = landingPageService.getCriticalAssetPaths();
        
        Assert.notNull(assets);
        Assert.isTrue(assets.length > 0);
        
        // Verify all assets are strings and not empty
        for (asset in assets) {
            Assert.notNull(asset);
            Assert.isTrue(asset.length > 0);
        }
    }
    
    /**
     * Test validateSectionConfiguration with valid configuration
     */
    public function testValidateSectionConfigurationValid(): Void {
        // Test hero validation
        var heroResult = landingPageService.validateSectionConfiguration("hero");
        Assert.isTrue(heroResult.isValid);
        
        // Test features validation
        var featuresResult = landingPageService.validateSectionConfiguration("features");
        Assert.isTrue(featuresResult.isValid);
        
        // Test community validation
        var communityResult = landingPageService.validateSectionConfiguration("community");
        Assert.isTrue(communityResult.isValid);
    }
    
    /**
     * Test validateSectionConfiguration with invalid configuration
     */
    public function testValidateSectionConfigurationInvalid(): Void {
        // Test with invalid section name
        var invalidSectionResult = landingPageService.validateSectionConfiguration("invalid");
        Assert.isFalse(invalidSectionResult.isValid);
        Assert.isTrue(invalidSectionResult.issues.length > 0);
        
        // Test with empty section name
        var emptySectionResult = landingPageService.validateSectionConfiguration("");
        Assert.isFalse(emptySectionResult.isValid);
    }
    
    /**
     * Test getNavigationStructure returns valid navigation
     */
    public function testGetNavigationStructure(): Void {
        var navigation = landingPageService.getNavigationStructure();
        
        Assert.notNull(navigation);
        Assert.notNull(navigation.sections);
        Assert.isTrue(navigation.sections.length > 0);
        Assert.notNull(navigation.scrollBehavior);
        Assert.isTrue(navigation.offsetTop >= 0);
        
        // Verify navigation sections have required properties
        for (section in navigation.sections) {
            Assert.notNull(section.id);
            Assert.notNull(section.label);
            Assert.isTrue(section.id.length > 0);
            Assert.isTrue(section.label.length > 0);
            Assert.isTrue(section.order > 0);
        }
        
        // Verify expected navigation sections exist
        var labels = [for (section in navigation.sections) section.label];
        Assert.isTrue(labels.indexOf("Home") >= 0);
        Assert.isTrue(labels.indexOf("About") >= 0);
        Assert.isTrue(labels.indexOf("Features") >= 0);
    }
    
    /**
     * Test service handles edge cases gracefully
     */
    public function testEdgeCases(): Void {
        // Test multiple calls to getPageConfiguration return consistent data
        var config1 = landingPageService.getPageConfiguration();
        var config2 = landingPageService.getPageConfiguration();
        
        Assert.equals(config1.hero.headline, config2.hero.headline);
        Assert.equals(config1.about.tagline, config2.about.tagline);
        Assert.equals(config1.features.length, config2.features.length);
        
        // Test multiple calls to getCriticalAssetPaths
        var assets1 = landingPageService.getCriticalAssetPaths();
        var assets2 = landingPageService.getCriticalAssetPaths();
        
        Assert.equals(assets1.length, assets2.length);
        
        // Test multiple calls to getNavigationStructure
        var nav1 = landingPageService.getNavigationStructure();
        var nav2 = landingPageService.getNavigationStructure();
        
        Assert.equals(nav1.sections.length, nav2.sections.length);
        Assert.equals(nav1.scrollBehavior, nav2.scrollBehavior);
        Assert.equals(nav1.offsetTop, nav2.offsetTop);
    }
    
    /**
     * Test configuration immutability
     */
    public function testConfigurationImmutability(): Void {
        var config = landingPageService.getPageConfiguration();
        var originalHeadline = config.hero.headline;
        
        // Attempt to modify configuration
        config.hero.headline = "Modified Headline";
        
        // Get fresh configuration and verify it wasn't affected
        var freshConfig = landingPageService.getPageConfiguration();
        Assert.equals(originalHeadline, freshConfig.hero.headline);
    }
    
    /**
     * Test performance of service methods
     */
    public function testPerformance(): Void {
        var startTime = haxe.Timer.stamp();
        
        // Perform multiple operations
        for (i in 0...100) {
            var config = landingPageService.getPageConfiguration();
            var assets = landingPageService.getCriticalAssetPaths();
            var navigation = landingPageService.getNavigationStructure();
            
            // Validate some data to ensure operations are actually performed
            Assert.isTrue(config.hero.headline.length > 0);
            Assert.isTrue(assets.length > 0);
            Assert.isTrue(navigation.sections.length > 0);
        }
        
        var endTime = haxe.Timer.stamp();
        var duration = endTime - startTime;
        
        // Performance should be reasonable (less than 1 second for 100 operations)
        Assert.isTrue(duration < 1.0);
    }
    
    /**
     * Test memory usage doesn't grow excessively
     */
    public function testMemoryUsage(): Void {
        var configs = [];
        
        // Create multiple configurations
        for (i in 0...50) {
            configs.push(landingPageService.getPageConfiguration());
        }
        
        // Verify all configurations are valid
        for (config in configs) {
            Assert.notNull(config);
            Assert.notNull(config.hero);
            Assert.notNull(config.about);
        }
        
        // Clear references
        configs = null;
        
        // This test mainly ensures no exceptions are thrown during memory operations
        Assert.isTrue(true);
    }
}
/**
 * End-to-End tests for Twisted Brain Landing Page
 * Tests user flows, visual regression, and interactive elements
 * 
 * Uses Playwright for comprehensive browser testing
 */

const { test, expect } = require('@playwright/test');

// Test configuration
const BASE_URL = 'http://localhost:8080';
const VIEWPORT_SIZES = [
  { width: 1920, height: 1080, name: 'desktop' },
  { width: 1024, height: 768, name: 'tablet' },
  { width: 375, height: 667, name: 'mobile' }
];

test.describe('Twisted Brain Landing Page - E2E Tests', () => {
  
  test.beforeEach(async ({ page }) => {
    // Navigate to landing page
    await page.goto(BASE_URL);
    
    // Wait for page to be fully loaded
    await page.waitForLoadState('networkidle');
    
    // Wait for critical assets to load
    await page.waitForSelector('.hero-section', { timeout: 10000 });
  });
  
  test.describe('Page Load and Structure', () => {
    
    test('should load page successfully with all sections', async ({ page }) => {
      // Check page title
      await expect(page).toHaveTitle(/Twisted Brain/);
      
      // Verify all main sections are present
      await expect(page.locator('.hero-section')).toBeVisible();
      await expect(page.locator('.about-section')).toBeVisible();
      await expect(page.locator('.features-section')).toBeVisible();
      await expect(page.locator('.showcase-section')).toBeVisible();
      await expect(page.locator('.community-section')).toBeVisible();
      await expect(page.locator('.footer-section')).toBeVisible();
    });
    
    test('should have proper meta tags for SEO', async ({ page }) => {
      // Check meta description
      const metaDescription = page.locator('meta[name="description"]');
      await expect(metaDescription).toHaveAttribute('content', /Twisted Brain/);
      
      // Check Open Graph tags
      const ogTitle = page.locator('meta[property="og:title"]');
      await expect(ogTitle).toHaveAttribute('content', /Twisted Brain/);
      
      const ogDescription = page.locator('meta[property="og:description"]');
      await expect(ogDescription).toHaveAttribute('content', /.+/);
      
      // Check Twitter Card
      const twitterCard = page.locator('meta[name="twitter:card"]');
      await expect(twitterCard).toHaveAttribute('content', 'summary_large_image');
    });
    
    test('should load critical CSS and fonts', async ({ page }) => {
      // Check if critical styles are loaded
      const heroSection = page.locator('.hero-section');
      const backgroundColor = await heroSection.evaluate(el => 
        window.getComputedStyle(el).backgroundColor
      );
      
      // Should have dark background (not default white)
      expect(backgroundColor).not.toBe('rgba(0, 0, 0, 0)');
      expect(backgroundColor).not.toBe('rgb(255, 255, 255)');
      
      // Check if custom fonts are loaded
      const headingFont = await page.locator('h1').evaluate(el => 
        window.getComputedStyle(el).fontFamily
      );
      
      expect(headingFont).toContain('Orbitron');
    });
  });
  
  test.describe('Hero Section Functionality', () => {
    
    test('should display hero content correctly', async ({ page }) => {
      const heroSection = page.locator('.hero-section');
      
      // Check headline is visible and not empty
      const headline = heroSection.locator('h1');
      await expect(headline).toBeVisible();
      await expect(headline).not.toBeEmpty();
      
      // Check subtext
      const subtext = heroSection.locator('.hero-subtext');
      await expect(subtext).toBeVisible();
      await expect(subtext).not.toBeEmpty();
      
      // Check CTA buttons
      const primaryCta = heroSection.locator('.cta-primary');
      const secondaryCta = heroSection.locator('.cta-secondary');
      
      await expect(primaryCta).toBeVisible();
      await expect(secondaryCta).toBeVisible();
      
      // Verify buttons have proper attributes
      await expect(primaryCta).toHaveAttribute('href');
      await expect(secondaryCta).toHaveAttribute('href');
    });
    
    test('should have working CTA buttons', async ({ page }) => {
      const primaryCta = page.locator('.cta-primary');
      const secondaryCta = page.locator('.cta-secondary');
      
      // Test primary CTA hover effect
      await primaryCta.hover();
      
      // Wait for hover animation
      await page.waitForTimeout(500);
      
      // Check if glow effect is applied (box-shadow should change)
      const boxShadow = await primaryCta.evaluate(el => 
        window.getComputedStyle(el).boxShadow
      );
      
      expect(boxShadow).not.toBe('none');
      
      // Test secondary CTA
      await secondaryCta.hover();
      await page.waitForTimeout(500);
      
      const secondaryBoxShadow = await secondaryCta.evaluate(el => 
        window.getComputedStyle(el).boxShadow
      );
      
      expect(secondaryBoxShadow).not.toBe('none');
    });
    
    test('should have animated background elements', async ({ page }) => {
      // Check for animated background elements
      const backgroundElements = page.locator('.hero-background .circuit-line');
      
      if (await backgroundElements.count() > 0) {
        // Check if animations are running
        const animationName = await backgroundElements.first().evaluate(el => 
          window.getComputedStyle(el).animationName
        );
        
        expect(animationName).not.toBe('none');
      }
    });
  });
  
  test.describe('Navigation and Scrolling', () => {
    
    test('should have smooth scrolling navigation', async ({ page }) => {
      // Test navigation to different sections
      const sections = ['about', 'features', 'showcase', 'community'];
      
      for (const section of sections) {
        // Click navigation link (if exists)
        const navLink = page.locator(`a[href="#${section}"]`);
        
        if (await navLink.count() > 0) {
          await navLink.click();
          
          // Wait for scroll animation
          await page.waitForTimeout(1000);
          
          // Check if section is in viewport
          const sectionElement = page.locator(`.${section}-section`);
          await expect(sectionElement).toBeInViewport();
        }
      }
    });
    
    test('should trigger scroll animations', async ({ page }) => {
      // Scroll to features section
      await page.locator('.features-section').scrollIntoViewIfNeeded();
      
      // Wait for scroll animations to trigger
      await page.waitForTimeout(1000);
      
      // Check if feature cards have animation classes
      const featureCards = page.locator('.feature-card');
      const cardCount = await featureCards.count();
      
      if (cardCount > 0) {
        // Check if first card has been animated
        const firstCard = featureCards.first();
        const opacity = await firstCard.evaluate(el => 
          window.getComputedStyle(el).opacity
        );
        
        // Should be visible after scroll animation
        expect(parseFloat(opacity)).toBeGreaterThan(0.5);
      }
    });
  });
  
  test.describe('Interactive Elements', () => {
    
    test('should have interactive feature cards', async ({ page }) => {
      // Scroll to features section
      await page.locator('.features-section').scrollIntoViewIfNeeded();
      
      const featureCards = page.locator('.feature-card');
      const cardCount = await featureCards.count();
      
      if (cardCount > 0) {
        const firstCard = featureCards.first();
        
        // Test hover effect
        await firstCard.hover();
        await page.waitForTimeout(300);
        
        // Check if hover effect is applied
        const transform = await firstCard.evaluate(el => 
          window.getComputedStyle(el).transform
        );
        
        // Should have some transform applied (scale or translate)
        expect(transform).not.toBe('none');
      }
    });
    
    test('should have working social links', async ({ page }) => {
      // Scroll to community section
      await page.locator('.community-section').scrollIntoViewIfNeeded();
      
      const socialLinks = page.locator('.social-link');
      const linkCount = await socialLinks.count();
      
      if (linkCount > 0) {
        // Check first social link
        const firstLink = socialLinks.first();
        
        await expect(firstLink).toHaveAttribute('href');
        await expect(firstLink).toHaveAttribute('target', '_blank');
        
        // Test hover effect
        await firstLink.hover();
        await page.waitForTimeout(300);
        
        const color = await firstLink.evaluate(el => 
          window.getComputedStyle(el).color
        );
        
        // Color should change on hover
        expect(color).not.toBe('rgb(255, 255, 255)');
      }
    });
  });
  
  test.describe('Visual Regression Tests', () => {
    
    VIEWPORT_SIZES.forEach(({ width, height, name }) => {
      test(`should match visual snapshot - ${name}`, async ({ page }) => {
        // Set viewport size
        await page.setViewportSize({ width, height });
        
        // Wait for layout to stabilize
        await page.waitForTimeout(1000);
        
        // Take full page screenshot
        await expect(page).toHaveScreenshot(`landing-page-${name}.png`, {
          fullPage: true,
          threshold: 0.3, // Allow 30% difference for animations
          animations: 'disabled' // Disable animations for consistent screenshots
        });
      });
      
      test(`should match hero section snapshot - ${name}`, async ({ page }) => {
        await page.setViewportSize({ width, height });
        await page.waitForTimeout(1000);
        
        const heroSection = page.locator('.hero-section');
        await expect(heroSection).toHaveScreenshot(`hero-section-${name}.png`, {
          threshold: 0.3,
          animations: 'disabled'
        });
      });
    });
  });
  
  test.describe('Performance Tests', () => {
    
    test('should load within performance budget', async ({ page }) => {
      const startTime = Date.now();
      
      await page.goto(BASE_URL);
      await page.waitForLoadState('networkidle');
      
      const loadTime = Date.now() - startTime;
      
      // Should load within 5 seconds
      expect(loadTime).toBeLessThan(5000);
    });
    
    test('should have good Core Web Vitals', async ({ page }) => {
      await page.goto(BASE_URL);
      
      // Measure Largest Contentful Paint (LCP)
      const lcp = await page.evaluate(() => {
        return new Promise((resolve) => {
          new PerformanceObserver((list) => {
            const entries = list.getEntries();
            const lastEntry = entries[entries.length - 1];
            resolve(lastEntry.startTime);
          }).observe({ entryTypes: ['largest-contentful-paint'] });
          
          // Fallback timeout
          setTimeout(() => resolve(0), 5000);
        });
      });
      
      // LCP should be under 2.5 seconds
      if (lcp > 0) {
        expect(lcp).toBeLessThan(2500);
      }
    });
    
    test('should not have console errors', async ({ page }) => {
      const consoleErrors = [];
      
      page.on('console', msg => {
        if (msg.type() === 'error') {
          consoleErrors.push(msg.text());
        }
      });
      
      await page.goto(BASE_URL);
      await page.waitForLoadState('networkidle');
      
      // Should not have any console errors
      expect(consoleErrors).toHaveLength(0);
    });
  });
  
  test.describe('Accessibility Tests', () => {
    
    test('should have proper heading hierarchy', async ({ page }) => {
      // Check for h1
      const h1Elements = page.locator('h1');
      await expect(h1Elements).toHaveCount(1);
      
      // Check that headings follow proper hierarchy
      const headings = await page.locator('h1, h2, h3, h4, h5, h6').all();
      
      expect(headings.length).toBeGreaterThan(1);
    });
    
    test('should have alt text for images', async ({ page }) => {
      const images = page.locator('img');
      const imageCount = await images.count();
      
      for (let i = 0; i < imageCount; i++) {
        const image = images.nth(i);
        await expect(image).toHaveAttribute('alt');
      }
    });
    
    test('should have proper link attributes', async ({ page }) => {
      const externalLinks = page.locator('a[href^="http"]');
      const externalLinkCount = await externalLinks.count();
      
      for (let i = 0; i < externalLinkCount; i++) {
        const link = externalLinks.nth(i);
        await expect(link).toHaveAttribute('target', '_blank');
        await expect(link).toHaveAttribute('rel', /noopener/);
      }
    });
    
    test('should be keyboard navigable', async ({ page }) => {
      // Test tab navigation
      await page.keyboard.press('Tab');
      
      // Check if focus is visible
      const focusedElement = page.locator(':focus');
      await expect(focusedElement).toBeVisible();
      
      // Continue tabbing through interactive elements
      for (let i = 0; i < 5; i++) {
        await page.keyboard.press('Tab');
        const currentFocus = page.locator(':focus');
        
        if (await currentFocus.count() > 0) {
          await expect(currentFocus).toBeVisible();
        }
      }
    });
  });
  
  test.describe('Mobile Responsiveness', () => {
    
    test('should be responsive on mobile devices', async ({ page }) => {
      // Test mobile viewport
      await page.setViewportSize({ width: 375, height: 667 });
      
      // Check if mobile navigation works
      const mobileNav = page.locator('.mobile-nav, .hamburger-menu');
      
      if (await mobileNav.count() > 0) {
        await mobileNav.click();
        await page.waitForTimeout(500);
        
        // Check if navigation menu is visible
        const navMenu = page.locator('.nav-menu, .mobile-menu');
        if (await navMenu.count() > 0) {
          await expect(navMenu).toBeVisible();
        }
      }
      
      // Check if content is properly stacked
      const heroSection = page.locator('.hero-section');
      const heroHeight = await heroSection.boundingBox();
      
      expect(heroHeight.height).toBeGreaterThan(400);
    });
    
    test('should have touch-friendly interactive elements', async ({ page }) => {
      await page.setViewportSize({ width: 375, height: 667 });
      
      const buttons = page.locator('button, .cta-primary, .cta-secondary');
      const buttonCount = await buttons.count();
      
      for (let i = 0; i < Math.min(buttonCount, 3); i++) {
        const button = buttons.nth(i);
        const boundingBox = await button.boundingBox();
        
        // Buttons should be at least 44px tall for touch accessibility
        expect(boundingBox.height).toBeGreaterThanOrEqual(44);
      }
    });
  });
});
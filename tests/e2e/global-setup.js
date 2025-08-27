/**
 * Global setup for Playwright E2E tests
 * Handles test environment preparation and cleanup
 */

const { chromium } = require('@playwright/test');
const path = require('path');
const fs = require('fs');

async function globalSetup(config) {
  console.log('🚀 Starting Twisted Brain E2E Test Setup...');
  
  // Get baseURL from config with fallback
  const baseURL = config?.use?.baseURL || 'http://localhost:8080';
  console.log(`🌐 Using baseURL: ${baseURL}`);
  
  // Ensure test results directory exists
  const testResultsDir = path.join(__dirname, '../../test-results');
  if (!fs.existsSync(testResultsDir)) {
    fs.mkdirSync(testResultsDir, { recursive: true });
    console.log('✅ Created test results directory');
  }
  
  // Ensure screenshots directory exists
  const screenshotsDir = path.join(testResultsDir, 'screenshots');
  if (!fs.existsSync(screenshotsDir)) {
    fs.mkdirSync(screenshotsDir, { recursive: true });
    console.log('✅ Created screenshots directory');
  }
  
  // Ensure artifacts directory exists
  const artifactsDir = path.join(testResultsDir, 'artifacts');
  if (!fs.existsSync(artifactsDir)) {
    fs.mkdirSync(artifactsDir, { recursive: true });
    console.log('✅ Created artifacts directory');
  }
  
  // Wait for the web server to be ready
  console.log('⏳ Waiting for web server to be ready...');
  
  const browser = await chromium.launch();
  const page = await browser.newPage();
  
  try {
    // Try to connect to the server with retries
    let retries = 30;
    let connected = false;
    
    while (retries > 0 && !connected) {
      try {
        const response = await page.goto(baseURL, {
          waitUntil: 'networkidle',
          timeout: 5000
        });
        
        if (response && response.ok()) {
          connected = true;
          console.log('✅ Web server is ready');
        }
      } catch (error) {
        retries--;
        if (retries > 0) {
          console.log(`⏳ Retrying connection... (${retries} attempts left)`);
          await new Promise(resolve => setTimeout(resolve, 2000));
        } else {
          throw new Error(`Failed to connect to web server at ${baseURL}`);
        }
      }
    }
    
    // Verify critical assets are loading
    console.log('🔍 Verifying critical assets...');
    
    // Check if main CSS is loaded
    const cssLoaded = await page.evaluate(() => {
      const links = document.querySelectorAll('link[rel="stylesheet"]');
      return links.length > 0;
    });
    
    if (cssLoaded) {
      console.log('✅ CSS assets verified');
    } else {
      console.warn('⚠️  CSS assets may not be loading properly');
    }
    
    // Check if main JavaScript is loaded
    const jsLoaded = await page.evaluate(() => {
      return typeof window.TwistedBrainApp !== 'undefined' || 
             document.querySelector('script[src*="TwistedBrainApp"]') !== null;
    });
    
    if (jsLoaded) {
      console.log('✅ JavaScript assets verified');
    } else {
      console.warn('⚠️  JavaScript assets may not be loading properly');
    }
    
    // Check if main sections are rendered
    const sectionsLoaded = await page.evaluate(() => {
      const sections = [
        '.hero-section',
        '.about-section', 
        '.features-section',
        '.showcase-section',
        '.community-section',
        '.footer-section'
      ];
      
      return sections.every(selector => 
        document.querySelector(selector) !== null
      );
    });
    
    if (sectionsLoaded) {
      console.log('✅ All page sections verified');
    } else {
      console.warn('⚠️  Some page sections may not be rendering properly');
    }
    
    // Take a baseline screenshot for visual regression
    console.log('📸 Taking baseline screenshot...');
    
    await page.setViewportSize({ width: 1280, height: 720 });
    await page.screenshot({
      path: path.join(screenshotsDir, 'baseline-desktop.png'),
      fullPage: true
    });
    
    // Mobile baseline
    await page.setViewportSize({ width: 375, height: 667 });
    await page.screenshot({
      path: path.join(screenshotsDir, 'baseline-mobile.png'),
      fullPage: true
    });
    
    console.log('✅ Baseline screenshots captured');
    
  } catch (error) {
    console.error('❌ Global setup failed:', error.message);
    throw error;
  } finally {
    await browser.close();
  }
  
  // Create test environment info file
  const envInfo = {
    timestamp: new Date().toISOString(),
    baseURL: baseURL,
    nodeVersion: process.version,
    platform: process.platform,
    arch: process.arch,
    ci: !!process.env.CI,
    environment: process.env.NODE_ENV || 'test'
  };
  
  fs.writeFileSync(
    path.join(testResultsDir, 'environment.json'),
    JSON.stringify(envInfo, null, 2)
  );
  
  console.log('✅ Environment info saved');
  console.log('🎉 Global setup completed successfully');
  console.log('');
}

module.exports = globalSetup;
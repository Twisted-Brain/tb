package platform.js;

import haxe.macro.Context;
import haxe.macro.Expr;
import sys.FileSystem;
import sys.io.File;

/**
 * Build macros for JavaScript platform compilation.
 * Handles output directory creation and HTML wrapper generation.
 */
class BuildMacros {
    
    /**
     * Create output directory if it doesn't exist
     */
    public static macro function createOutputDir(): Expr {
        var outputDir = "build/js";
        
        if (!FileSystem.exists(outputDir)) {
            FileSystem.createDirectory(outputDir);
            Context.info('Created output directory: $outputDir', Context.currentPos());
        }
        
        return macro null;
    }
    
    /**
     * Generate HTML wrapper for the JavaScript application
     */
    public static macro function generateIndexHtml(): Expr {
        var htmlContent = '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Twisted Brain - Futuristic Development Platform</title>
    
    <!-- SEO Meta Tags -->
    <meta name="description" content="Twisted Brain: Revolutionary development platform with futuristic neon aesthetics and cutting-edge technology.">
    <meta name="keywords" content="twisted brain, development platform, haxe, futuristic, neon, technology">
    <meta name="author" content="Twisted Brain Team">
    
    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="Twisted Brain - Futuristic Development Platform">
    <meta property="og:description" content="Revolutionary development platform with futuristic neon aesthetics and cutting-edge technology.">
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://twisted-brain.github.io/">
    <meta property="og:image" content="https://twisted-brain.github.io/assets/images/og-image.jpg">
    
    <!-- Twitter Card Meta Tags -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="Twisted Brain - Futuristic Development Platform">
    <meta name="twitter:description" content="Revolutionary development platform with futuristic neon aesthetics and cutting-edge technology.">
    <meta name="twitter:image" content="https://twisted-brain.github.io/assets/images/twitter-card.jpg">
    
    <!-- Preload Critical Resources -->
    <link rel="preload" href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Roboto+Mono:wght@300;400;500&display=swap" as="style">
    <link rel="preload" href="./styles.css" as="style">
    <link rel="preload" href="./js/TwistedBrainApp.js" as="script">
    
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Roboto+Mono:wght@300;400;500&display=swap" rel="stylesheet">
    
    <!-- Styles -->
    <link rel="stylesheet" href="./styles.css">
    
    <!-- Favicon -->
    <link rel="icon" type="image/png" href="./favicon.png">
    
    <style>
        /* Critical CSS for loading state */
        .loading-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #0a0a0a 0%, #1a1a2e 50%, #16213e 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            transition: opacity 0.5s ease-out;
        }
        
        .loading-spinner {
            width: 60px;
            height: 60px;
            border: 3px solid rgba(0, 255, 255, 0.1);
            border-top: 3px solid #00ffff;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            box-shadow: 0 0 20px rgba(0, 255, 255, 0.3);
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .loading-text {
            color: #00ffff;
            font-family: "Orbitron", monospace;
            font-size: 18px;
            margin-top: 20px;
            text-shadow: 0 0 10px rgba(0, 255, 255, 0.5);
            animation: pulse 2s ease-in-out infinite;
        }
        
        @keyframes pulse {
            0%, 100% { opacity: 0.7; }
            50% { opacity: 1; }
        }
        
        .error-container {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(255, 0, 0, 0.1);
            border: 2px solid #ff0040;
            border-radius: 10px;
            padding: 30px;
            color: #ff0040;
            font-family: "Roboto Mono", monospace;
            text-align: center;
            box-shadow: 0 0 30px rgba(255, 0, 64, 0.3);
            z-index: 10000;
        }
    </style>
</head>
<body>
    <!-- Loading Screen -->
    <div id="loading-container" class="loading-container">
        <div>
            <div class="loading-spinner"></div>
            <div class="loading-text">Initializing Twisted Brain...</div>
        </div>
    </div>
    
    <!-- Error Screen -->
    <div id="error-container" class="error-container">
        <h2>🚨 System Error</h2>
        <p>Failed to initialize Twisted Brain application.</p>
        <p>Please check the console for details and try refreshing the page.</p>
    </div>
    
    <!-- Main Application Container -->
    <div id="app-container"></div>
    
    <!-- Application Script -->
    <script>
        // Error handling
        window.addEventListener(\'error\', function(e) {
            console.error(\'Application Error:\', e.error);
            document.getElementById(\'loading-container\').style.display = \'none\';
            document.getElementById(\'error-container\').style.display = \'block\';
        });
        
        // Load application
        function initializeApp() {
            try {
                // Hide loading screen after app initialization
                setTimeout(function() {
                    var loadingContainer = document.getElementById(\'loading-container\');
                    if (loadingContainer) {
                        loadingContainer.style.opacity = \'0\';
                        setTimeout(function() {
                            loadingContainer.style.display = \'none\';
                        }, 500);
                    }
                }, 1000);
            } catch (error) {
                console.error(\'Failed to initialize app:\', error);
                document.getElementById(\'loading-container\').style.display = \'none\';
                document.getElementById(\'error-container\').style.display = \'block\';
            }
        }
        
        // Initialize when DOM is ready
        if (document.readyState === \'loading\') {
            document.addEventListener(\'DOMContentLoaded\', initializeApp);
        } else {
            initializeApp();
        }
    </script>
    
    <!-- Main Application -->
    <script src="./js/TwistedBrainApp.js"></script>
</body>
</html>';
        
        var outputPath = "build/index.html";
        
        try {
            File.saveContent(outputPath, htmlContent);
            Context.info('Generated HTML wrapper: $outputPath', Context.currentPos());
        } catch (e: Dynamic) {
            Context.error('Failed to generate HTML wrapper: $e', Context.currentPos());
        }
        
        return macro null;
    }
    
    /**
     * Copy static assets to build directory
     */
    public static macro function copyAssets(): Expr {
        var platformSourceDir = "platform/js";
        var assetsSourceDir = "assets";
        var targetDir = "build";
        var assetsTargetDir = "build/assets";
        
        // Create assets directory in build
        if (!FileSystem.exists(assetsTargetDir)) {
            FileSystem.createDirectory(assetsTargetDir);
            Context.info('Created assets directory: $assetsTargetDir', Context.currentPos());
        }
        
        // Copy CSS file from platform
        if (FileSystem.exists('$platformSourceDir/styles.css')) {
            try {
                var cssContent = File.getContent('$platformSourceDir/styles.css');
                File.saveContent('$targetDir/styles.css', cssContent);
                Context.info('Copied styles.css to build directory', Context.currentPos());
            } catch (e: Dynamic) {
                Context.warning('Failed to copy styles.css: $e', Context.currentPos());
            }
        }
        
        // Copy only the assets that are actually used in the application
        var requiredAssets = [
            "tb.png",
            "hdevm.png", 
            "tb_3.png",
            "tb_4.png",
            "tb_5.png",
            "hdevm_1.png",
            "logo.png",
            "xrd.png"
        ];
        
        if (FileSystem.exists(assetsSourceDir)) {
            try {
                var copiedCount = 0;
                
                for (file in requiredAssets) {
                    var sourcePath = '$assetsSourceDir/$file';
                    var targetPath = '$assetsTargetDir/$file';
                    
                    if (FileSystem.exists(sourcePath)) {
                        try {
                            var content = File.getBytes(sourcePath);
                            File.saveBytes(targetPath, content);
                            copiedCount++;
                            Context.info('Copied required asset: $file', Context.currentPos());
                        } catch (e: Dynamic) {
                            Context.warning('Failed to copy required asset $file: $e', Context.currentPos());
                        }
                    } else {
                        Context.warning('Required asset not found: $file', Context.currentPos());
                    }
                }
                
                Context.info('Copied $copiedCount required asset files to build directory', Context.currentPos());
            } catch (e: Dynamic) {
                Context.warning('Failed to copy required assets: $e', Context.currentPos());
            }
        }
        
        // Copy favicon files (PNG only - no SVG available)
        if (FileSystem.exists('$assetsSourceDir/logo.png')) {
            try {
                var logoContent = File.getBytes('$assetsSourceDir/logo.png');
                File.saveBytes('$targetDir/favicon.png', logoContent);
                Context.info('Copied favicon.png to build directory', Context.currentPos());
            } catch (e: Dynamic) {
                Context.warning('Failed to copy favicon.png: $e', Context.currentPos());
            }
        }
        
        return macro null;
    }
    
    /**
     * Validate build configuration
     */
    public static macro function validateBuild(): Expr {
        var requiredFiles = [
            "domain/LandingPageService.hx",
            "domain/LandingPageData.hx",
            "shared/AssetManager.hx",
            "shared/AnimationUtils.hx",
            "platform/js/TwistedBrainApp.hx"
        ];
        
        var missingFiles = [];
        
        for (file in requiredFiles) {
            if (!FileSystem.exists(file)) {
                missingFiles.push(file);
            }
        }
        
        if (missingFiles.length > 0) {
            Context.error('Missing required files: ${missingFiles.join(", ")}', Context.currentPos());
        } else {
            Context.info('Build validation passed - all required files present', Context.currentPos());
        }
        
        return macro null;
    }
}
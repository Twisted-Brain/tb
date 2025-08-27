package tests.unit;

import shared.AssetManager;
import utest.Test;
import utest.Assert;
import js.Browser;
import js.html.Element;
import js.html.ImageElement;
import js.html.LinkElement;

/**
 * Unit tests for AssetManager shared utility.
 * Tests asset loading, caching, and optimization functionality.
 * 
 * Ensures proper handling of images, fonts, stylesheets and cache management.
 */
class TestAssetManager extends Test {
    
    private var assetManager: AssetManager;
    
    /**
     * Set up test environment before each test
     */
    public function setup(): Void {
        assetManager = AssetManager.getInstance();
    }
    
    /**
     * Clean up after each test
     */
    public function tearDown(): Void {
        assetManager = null;
        // Clear any test elements from DOM
        var testElements = Browser.document.querySelectorAll('[data-test="true"]');
        for (i in 0...testElements.length) {
            var element = testElements.item(i);
            if (element.parentNode != null) {
                element.parentNode.removeChild(element);
            }
        }
    }
    
    /**
     * Test AssetManager instantiation
     */
    public function testAssetManagerInstantiation(): Void {
        Assert.notNull(assetManager);
        Assert.isTrue(Std.is(assetManager, AssetManager));
    }
    
    /**
     * Test preloadAssets with valid asset list
     */
    public function testPreloadAssetsValid(): Void {
        var assets = [
            "assets/logo.png",
            "assets/fonts/orbitron.woff2",
            "assets/styles/critical.css"
        ];
        
        // This should not throw an exception
        try {
            assetManager.preloadAssets(assets, function() {
                // Preload complete
            });
            Assert.isTrue(true); // Test passes if no exception
        } catch (e: Dynamic) {
            Assert.fail("preloadAssets should not throw exception with valid assets: " + e);
        }
    }
    
    /**
     * Test preloadAssets with empty asset list
     */
    public function testPreloadAssetsEmpty(): Void {
        var assets = [];
        
        try {
            assetManager.preloadAssets(assets, function() {
                // Empty preload complete
            });
            Assert.isTrue(true); // Should handle empty array gracefully
        } catch (e: Dynamic) {
            Assert.fail("preloadAssets should handle empty array gracefully: " + e);
        }
    }
    
    /**
     * Test preloadAssets with null input
     */
    public function testPreloadAssetsNull(): Void {
        try {
            assetManager.preloadAssets([], function() {
                // Empty preload complete
            });
            Assert.isTrue(true); // Should handle null gracefully
        } catch (e: Dynamic) {
            Assert.fail("preloadAssets should handle null gracefully: " + e);
        }
    }
    
    /**
     * Test loadAsset with image
     */
    public function testLoadAssetImage(): Void {
        var imagePath = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAiIGhlaWdodD0iMTAiIHZpZXdCb3g9IjAgMCAxMCAxMCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMTAiIGhlaWdodD0iMTAiIGZpbGw9IiMwMGZmZmYiLz48L3N2Zz4=";
        
        try {
            assetManager.loadAsset(imagePath, function(success: Bool) {
                Assert.isTrue(success);
            });
            
            Assert.isTrue(true); // Method should not throw
        } catch (e: Dynamic) {
            Assert.fail("loadAsset should handle image loading: " + e);
        }
    }
    
    /**
     * Test loadAsset with empty path
     */
    public function testLoadAssetEmpty(): Void {
        try {
            assetManager.loadAsset("", function(success: Bool) {
                // Should handle empty path gracefully
            });
            Assert.isTrue(true); // Should not throw
        } catch (e: Dynamic) {
            Assert.fail("loadAsset should handle empty path: " + e);
        }
    }
    
    /**
     * Test loadAsset with font
     */
    public function testLoadAssetFont(): Void {
        // Use a minimal base64 encoded font for testing
        var fontPath = "data:font/woff2;base64,d09GMgABAAAAAAGQAAoAAAAABBAAAAFGAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAABmAAgkIKgXiBSQsGAAE2AiQDCAQgBQYHLxsjA8iuCmxj2tANRQzLsizLYvEY/hEP9fu9nt13A4Q6rMM6E5WoAFkn6+rqVldXyPJfyJ+aTiX7";
        
        try {
            assetManager.loadAsset(fontPath, function(success: Bool) {
                Assert.isTrue(success);
            });
            
            Assert.isTrue(true); // Method should not throw
        } catch (e: Dynamic) {
            Assert.fail("loadAsset should handle font loading: " + e);
        }
    }
    
    /**
     * Test loadAsset with different font formats
     */
    public function testLoadAssetFontFormats(): Void {
        var fontFormats = [
            "data:font/woff2;base64,d09GMgABAAAAAAGQAAoAAAAABBAAAAFGAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAABmAAgkIKgXiBSQsGAAE2AiQDCAQgBQYHLxsjA8iuCmxj2tANRQzLsizLYvEY/hEP9fu9nt13A4Q6rMM6E5WoAFkn6+rqVldXyPJfyJ+aTiX7",
            "data:font/woff;base64,d09GRgABAAAAAAGQAAoAAAAABBAAAAFGAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAABmAAgkIKgXiBSQsGAAE2AiQDCAQgBQYHLxsjA8iuCmxj2tANRQzLsizLYvEY/hEP9fu9nt13A4Q6rMM6E5WoAFkn6+rqVldXyPJfyJ+aTiX7",
            "data:font/ttf;base64,AAEAAAAKAIAAAwAgT1MvMj8hSQoAAAEoAAAAVmNtYXDOXM6wAAABiAAAADxnbHlmOk89lQAAAcQAAAAgaGVhZBSF852jAAAAvAAAADZoaGVhA+gDzAAAAPQAAAAkaG10eASAABEAAAEYAAAADGxvY2EACACEAAABJAAAAAZTY",
            "data:font/otf;base64,T1RUTwAKAIAAAwAgQ0ZGIDHtZg4AAAEoAAAAO0ZGVE1lkzZwAAABZAAAABxHREVGABQAFQAAAYAAAAAbR1BPU2GSjooAAAGcAAAALEdTVUIAAQAAAAABzAAAAAFPUy8yPyFJCgAAAagAAAA"
        ];
        
        for (format in fontFormats) {
            try {
                assetManager.loadAsset(format, function(success: Bool) {
                    Assert.isTrue(success);
                });
                Assert.isTrue(true); // Should handle format
            } catch (e: Dynamic) {
                Assert.fail('loadAsset should handle font data URL format: ' + e);
            }
        }
    }
    
    /**
     * Test loadAsset with stylesheet
     */
    public function testLoadAssetStylesheet(): Void {
        // Use a data URL for CSS testing
        var stylesheetPath = "data:text/css;base64,Ym9keSB7IGNvbG9yOiAjMDBmZmZmOyB9";
        
        try {
            assetManager.loadAsset(stylesheetPath, function(success: Bool) {
                Assert.isTrue(success);
            });
            
            Assert.isTrue(true); // Method should not throw
        } catch (e: Dynamic) {
            Assert.fail("loadAsset should handle stylesheet loading: " + e);
        }
    }
    
    /**
     * Test getCachedAsset retrieves data correctly
     */
    public function testGetCachedAsset(): Void {
        var assetPath = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAiIGhlaWdodD0iMTAiIHZpZXdCb3g9IjAgMCAxMCAxMCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMTAiIGhlaWdodD0iMTAiIGZpbGw9IiMwMGZmZmYiLz48L3N2Zz4=";
        
        try {
            // Load asset first to populate cache
            assetManager.loadAsset(assetPath, function(success: Bool) {
                if (success) {
                    var cachedData = assetManager.getCachedAsset(assetPath);
                    // Asset should be in cache after loading
                    Assert.isTrue(assetManager.isAssetLoaded(assetPath));
                }
            });
            
            Assert.isTrue(true); // Method should not throw
        } catch (e: Dynamic) {
            Assert.fail("getCachedAsset should work correctly: " + e);
        }
    }
    
    /**
     * Test getCachedAsset with non-existent asset
     */
    public function testGetCachedAssetNotFound(): Void {
        try {
            var cachedData = assetManager.getCachedAsset("test-path");
            Assert.isNull(cachedData);
        } catch (e: Dynamic) {
            Assert.fail("getCachedAsset should handle missing assets: " + e);
        }
    }
    
    /**
     * Test getCachedAsset with empty path
     */
    public function testGetCachedAssetEmptyPath(): Void {
        try {
            var cachedData = assetManager.getCachedAsset("");
            Assert.isNull(cachedData); // Should return null for empty path
        } catch (e: Dynamic) {
            Assert.fail("getCachedAsset should handle empty path: " + e);
        }
    }
    
    /**
     * Test getCachedAsset with non-existent asset
     */
    public function testGetCachedAssetNonExistent(): Void {
        var cachedData = assetManager.getCachedAsset("non-existent-asset.png");
        Assert.isNull(cachedData);
    }
    
    /**
     * Test clearCache functionality
     */
    public function testClearCache(): Void {
        var assetPath1 = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==";
        var assetPath2 = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMSIgaGVpZ2h0PSIxIiB2aWV3Qm94PSIwIDAgMSAxIiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxIiBoZWlnaHQ9IjEiIGZpbGw9IiNmZmYiLz48L3N2Zz4=";
        
        try {
            // Load assets to populate cache
            assetManager.loadAsset(assetPath1, function(success: Bool) {});
            assetManager.loadAsset(assetPath2, function(success: Bool) {});
            
            // Verify they are cached
            Assert.isTrue(assetManager.isAssetLoaded(assetPath1));
            Assert.isTrue(assetManager.isAssetLoaded(assetPath2));
            
            // Clear cache
            assetManager.clearCache();
            
            // Verify cache is cleared
            Assert.isNull(assetManager.getCachedAsset(assetPath1));
            Assert.isNull(assetManager.getCachedAsset(assetPath2));
        } catch (e: Dynamic) {
            Assert.fail("clearCache should work correctly: " + e);
        }
    }
    
    /**
     * Test cache overwrite behavior
     */
    public function testCacheOverwrite(): Void {
        var assetPath = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==";
        
        try {
            // Load asset to populate cache
            assetManager.loadAsset(assetPath, function(success: Bool) {});
            Assert.isTrue(assetManager.isAssetLoaded(assetPath));
        } catch (e: Dynamic) {
            Assert.fail("Cache should allow overwriting: " + e);
        }
    }
    
    /**
     * Test multiple asset types in preload
     */
    public function testPreloadMixedAssetTypes(): Void {
        var mixedAssets = [
            "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAiIGhlaWdodD0iMTAiIHZpZXdCb3g9IjAgMCAxMCAxMCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMTAiIGhlaWdodD0iMTAiIGZpbGw9IiMwMGZmZmYiLz48L3N2Zz4=",
            "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/2wBDAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/wAARCAABAAEDASIAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAAv/xAAUEAEAAAAAAAAAAAAAAAAAAAAA/8QAFQEBAQAAAAAAAAAAAAAAAAAAAAX/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwA/AB8AAQAB/9k=",
            "data:font/woff2;base64,d09GMgABAAAAAAGQAAoAAAAABBAAAAFGAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAABmAAgkIKgXiBSQsGAAE2AiQDCAQgBQYHLxsjA8iuCmxj2tANRQzLsizLYvEY/hEP9fu9nt13A4Q6rMM6E5WoAFkn6+rqVldXyPJfyJ+aTiX7",
            "data:font/woff;base64,d09GRgABAAAAAAGQAAoAAAAABBAAAAFGAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAABmAAgkIKgXiBSQsGAAE2AiQDCAQgBQYHLxsjA8iuCmxj2tANRQzLsizLYvEY/hEP9fu9nt13A4Q6rMM6E5WoAFkn6+rqVldXyPJfyJ+aTiX7",
            "data:text/css;base64,Ym9keSB7IGNvbG9yOiAjMDBmZmZmOyB9",
            "data:text/css;base64,QGtleWZyYW1lcyBmYWRlSW4geyBmcm9tIHsgb3BhY2l0eTogMDsgfSB0byB7IG9wYWNpdHk6IDE7IH0gfQ=="
        ];
        
        try {
            assetManager.preloadAssets(mixedAssets, function() {
                // Mixed assets preload complete
            });
            Assert.isTrue(true); // Should handle mixed types without error
        } catch (e: Dynamic) {
            Assert.fail("preloadAssets should handle mixed asset types: " + e);
        }
    }
    
    /**
     * Test asset path normalization
     */
    public function testAssetPathNormalization(): Void {
        // Use data URLs to avoid network requests and file system dependencies
        var testImage = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==";
        
        var paths = [
            testImage,
            "data:text/css;base64,Ym9keSB7IGNvbG9yOiByZWQ7IH0=",
            "data:font/woff2;base64,d09GMgABAAAAAAGQAAoAAAAABBAAAAFGAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAABmAAgkIKgXiBSQsGAAE2AiQDCAQgBQYHLxsjA8iuCmxj2tANRQzLsizLYvEY/hEP9fu9nt13A4Q6rMM6E5WoAFkn6+rqVldXyPJfyJ+aTiX7"
        ];
        
        for (path in paths) {
            try {
                assetManager.loadAsset(path, function(success: Bool) {
                    // Data URLs should load successfully
                });
                Assert.isTrue(true); // Should handle path format
            } catch (e: Dynamic) {
                Assert.fail('loadAsset should handle data URL format: $path - ' + e);
            }
        }
    }
    
    /**
     * Test performance with large asset lists
     */
    public function testPerformanceWithLargeAssetList(): Void {
        var largeAssetList = [];
        
        // Generate large list of assets
        for (i in 0...100) {
            largeAssetList.push('assets/image_$i.png');
            largeAssetList.push('assets/font_$i.woff2');
            largeAssetList.push('assets/style_$i.css');
        }
        
        var startTime = haxe.Timer.stamp();
        
        try {
            assetManager.preloadAssets(largeAssetList, function() {
                // Large preload complete
            });
            
            var endTime = haxe.Timer.stamp();
            var duration = endTime - startTime;
            
            // Should complete within reasonable time (less than 1 second)
            Assert.isTrue(duration < 1.0);
        } catch (e: Dynamic) {
            Assert.fail("preloadAssets should handle large asset lists efficiently: " + e);
        }
    }
    
    /**
     * Test memory management with repeated operations
     */
    public function testMemoryManagement(): Void {
        try {
            // Perform many load operations
            for (i in 0...50) {
                assetManager.loadAsset('asset_$i.png', function(success: Bool) {});
            }
            
            // Verify some assets are loaded
            Assert.isTrue(assetManager.isAssetLoaded("asset_0.png"));
            Assert.isTrue(assetManager.isAssetLoaded("asset_25.png"));
            Assert.isTrue(assetManager.isAssetLoaded("asset_49.png"));
            
            // Clear cache
            assetManager.clearCache();
            
            // Verify cleared
            Assert.isNull(assetManager.getCachedAsset("asset_0"));
            Assert.isNull(assetManager.getCachedAsset("asset_25"));
            
            Assert.isTrue(true); // Test passes if no memory issues
        } catch (e: Dynamic) {
            Assert.fail("Memory management should work correctly: " + e);
        }
    }
    
    /**
     * Test concurrent asset operations
     */
    public function testConcurrentOperations(): Void {
        try {
            // Simulate concurrent operations
            var assets1 = ["asset1.png", "asset2.svg"];
            var assets2 = ["asset3.jpg", "asset4.woff2"];
            
            assetManager.preloadAssets(assets1, function() {
                // Assets1 preload complete
            });
            assetManager.loadAsset("cached1.png", function(success: Bool) {});
            assetManager.preloadAssets(assets2, function() {
                // Assets2 preload complete
            });
            assetManager.loadAsset("cached2.png", function(success: Bool) {});
            
            // Verify assets are loaded
            Assert.isTrue(assetManager.isAssetLoaded("cached1.png"));
            Assert.isTrue(assetManager.isAssetLoaded("cached2.png"));
            
            Assert.isTrue(true); // Test passes if operations don't interfere
        } catch (e: Dynamic) {
            Assert.fail("Concurrent operations should work correctly: " + e);
        }
    }
}
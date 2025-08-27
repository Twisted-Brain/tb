package shared;

/**
 * Asset management utility for handling images, fonts, and other resources.
 * Provides centralized asset loading, caching, and optimization.
 * 
 * This utility ensures efficient resource management across all platforms
 * while maintaining consistent asset paths and loading strategies.
 */
class AssetManager {
    
    private static var instance: AssetManager;
    private var loadedAssets: Map<String, Bool>;
    private var assetCache: Map<String, Dynamic>;
    
    /**
     * Singleton pattern for global asset management
     */
    public static function getInstance(): AssetManager {
        if (instance == null) {
            instance = new AssetManager();
        }
        return instance;
    }
    
    /**
     * Private constructor for singleton pattern
     */
    private function new() {
        loadedAssets = new Map<String, Bool>();
        assetCache = new Map<String, Dynamic>();
    }
    
    /**
     * Preload critical assets for faster page rendering
     * @param assetPaths Array of asset paths to preload
     * @param onComplete Callback when all assets are loaded
     * @param onProgress Progress callback with loaded/total counts
     */
    public function preloadAssets(
        assetPaths: Array<String>, 
        onComplete: Void -> Void,
        ?onProgress: (loaded: Int, total: Int) -> Void
    ): Void {
        var totalAssets = assetPaths.length;
        var loadedCount = 0;
        
        if (totalAssets == 0) {
            onComplete();
            return;
        }
        
        for (assetPath in assetPaths) {
            loadAsset(assetPath, function(success: Bool) {
                loadedCount++;
                
                if (onProgress != null) {
                    onProgress(loadedCount, totalAssets);
                }
                
                if (loadedCount >= totalAssets) {
                    onComplete();
                }
            });
        }
    }
    
    /**
     * Load a single asset with caching
     * @param assetPath Path to the asset
     * @param onComplete Callback with success status
     */
    public function loadAsset(assetPath: String, onComplete: Bool -> Void): Void {
        // Check if already loaded
        if (loadedAssets.exists(assetPath)) {
            onComplete(true);
            return;
        }
        
        // Determine asset type and load accordingly
        var extension = getFileExtension(assetPath).toLowerCase();
        
        switch (extension) {
            case "png", "jpg", "jpeg", "gif", "svg":
                loadImageAsset(assetPath, onComplete);
            case "woff", "woff2", "ttf", "otf":
                loadFontAsset(assetPath, onComplete);
            case "css":
                loadStyleAsset(assetPath, onComplete);
            default:
                // Generic resource loading
                loadGenericAsset(assetPath, onComplete);
        }
    }
    
    /**
     * Load image asset with proper error handling
     */
    private function loadImageAsset(assetPath: String, onComplete: Bool -> Void): Void {
        #if js
        var img = js.Browser.document.createImageElement();
        img.onload = function() {
            loadedAssets.set(assetPath, true);
            assetCache.set(assetPath, img);
            onComplete(true);
        };
        img.onerror = function() {
            trace('Failed to load image: $assetPath');
            onComplete(false);
        };
        img.src = assetPath;
        #else
        // Platform-specific image loading would go here
        loadedAssets.set(assetPath, true);
        onComplete(true);
        #end
    }
    
    /**
     * Load font asset for web fonts
     */
    private function loadFontAsset(assetPath: String, onComplete: Bool -> Void): Void {
        #if js
        var link = js.Browser.document.createLinkElement();
        link.rel = "preload";
        link.href = assetPath;
        link.setAttribute("as", "font");
        link.setAttribute("type", "font/woff2");
        link.setAttribute("crossorigin", "anonymous");
        
        link.onload = function() {
            loadedAssets.set(assetPath, true);
            onComplete(true);
        };
        link.onerror = function() {
            trace('Failed to load font: $assetPath');
            onComplete(false);
        };
        
        js.Browser.document.head.appendChild(link);
        #else
        loadedAssets.set(assetPath, true);
        onComplete(true);
        #end
    }
    
    /**
     * Load CSS stylesheet
     */
    private function loadStyleAsset(assetPath: String, onComplete: Bool -> Void): Void {
        #if js
        var link = js.Browser.document.createLinkElement();
        link.rel = "stylesheet";
        link.href = assetPath;
        
        link.onload = function() {
            loadedAssets.set(assetPath, true);
            onComplete(true);
        };
        link.onerror = function() {
            trace('Failed to load stylesheet: $assetPath');
            onComplete(false);
        };
        
        js.Browser.document.head.appendChild(link);
        #else
        loadedAssets.set(assetPath, true);
        onComplete(true);
        #end
    }
    
    /**
     * Generic asset loading fallback
     */
    private function loadGenericAsset(assetPath: String, onComplete: Bool -> Void): Void {
        // For now, just mark as loaded
        // In a real implementation, this would use appropriate loading mechanism
        loadedAssets.set(assetPath, true);
        onComplete(true);
    }
    
    /**
     * Get cached asset if available
     * @param assetPath Path to the asset
     * @return Cached asset or null if not found
     */
    public function getCachedAsset(assetPath: String): Dynamic {
        return assetCache.get(assetPath);
    }
    
    /**
     * Check if asset is loaded
     * @param assetPath Path to check
     * @return True if asset is loaded
     */
    public function isAssetLoaded(assetPath: String): Bool {
        return loadedAssets.exists(assetPath) && loadedAssets.get(assetPath);
    }
    
    /**
     * Get file extension from path
     */
    private function getFileExtension(path: String): String {
        var lastDot = path.lastIndexOf(".");
        if (lastDot == -1) return "";
        return path.substring(lastDot + 1);
    }
    
    /**
     * Clear asset cache (useful for memory management)
     */
    public function clearCache(): Void {
        loadedAssets.clear();
        assetCache.clear();
    }
    
    /**
     * Get loading statistics
     * @return Object with loading statistics
     */
    public function getLoadingStats(): AssetLoadingStats {
        var totalAssets = 0;
        var loadedAssets = 0;
        
        for (path in this.loadedAssets.keys()) {
            totalAssets++;
            if (this.loadedAssets.get(path)) {
                loadedAssets++;
            }
        }
        
        return {
            totalAssets: totalAssets,
            loadedAssets: loadedAssets,
            loadingProgress: totalAssets > 0 ? (loadedAssets / totalAssets) * 100 : 100,
            cacheSize: [for (key in assetCache.keys()) key].length
        };
    }
}

/**
 * Asset loading statistics structure
 */
typedef AssetLoadingStats = {
    totalAssets: Int,
    loadedAssets: Int,
    loadingProgress: Float,
    cacheSize: Int
}
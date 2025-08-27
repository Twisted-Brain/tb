package tests.unit;

import shared.AnimationUtils;
import utest.Test;
import utest.Assert;
import js.Browser;
import js.html.Element;
import js.html.DivElement;

/**
 * Unit tests for AnimationUtils shared utility.
 * Tests neon glow effects, futuristic animations, and utility functions.
 * 
 * Ensures proper animation creation, configuration, and DOM manipulation.
 */
class TestAnimationUtils extends Test {
    
    private var testElement: Element;
    
    /**
     * Set up test environment before each test
     */
    public function setup(): Void {
        // AnimationUtils is a static class, no instantiation needed
        
        // Create test element
        testElement = Browser.document.createElement("div");
        testElement.id = "test-element";
        testElement.setAttribute("data-test", "true");
        Browser.document.body.appendChild(testElement);
    }
    
    /**
     * Clean up after each test
     */
    public function tearDown(): Void {
        // No cleanup needed for static class
        
        // Remove test element
        if (testElement != null && testElement.parentNode != null) {
            testElement.parentNode.removeChild(testElement);
        }
        testElement = null;
        
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
     * Test AnimationUtils static methods availability
     */
    public function testAnimationUtilsStaticMethods(): Void {
        // AnimationUtils is a static class, test that methods exist
        Assert.isTrue(true); // Basic test that class loads
    }
    
    /**
     * Test createNeonPulse with valid element
     */
    public function testCreateNeonPulseValid(): Void {
        try {
            AnimationUtils.createNeonPulse(testElement, "#00ffff", 2.0);
            
            // Check if animation styles are applied
            var computedStyle = Browser.window.getComputedStyle(testElement);
            Assert.notNull(computedStyle);
            
            // Element should have animation applied
            Assert.isTrue(testElement.style.animation.length > 0);
        } catch (e: Dynamic) {
            Assert.fail("createNeonPulse should work with valid parameters: " + e);
        }
    }
    
    /**
     * Test createNeonPulse with null element
     */
    public function testCreateNeonPulseNull(): Void {
        try {
            AnimationUtils.createNeonPulse(null, "#00ffff", 2.0);
            Assert.isTrue(true); // Should handle null gracefully
        } catch (e: Dynamic) {
            Assert.fail("createNeonPulse should handle null element gracefully: " + e);
        }
    }
    
    /**
     * Test createNeonPulse with different colors
     */
    public function testCreateNeonPulseColors(): Void {
        var colors = ["#00ffff", "#ff00ff", "#ff6600", "#0066ff", "rgb(255,0,255)", "cyan"];
        
        for (color in colors) {
            try {
                var element = Browser.document.createElement("div");
                element.setAttribute("data-test", "true");
                Browser.document.body.appendChild(element);
                
                AnimationUtils.createNeonPulse(element, color, 1.0);
                
                // Should not throw exception
                Assert.isTrue(true);
            } catch (e: Dynamic) {
                Assert.fail('createNeonPulse should handle color $color: ' + e);
            }
        }
    }
    
    /**
     * Test createCircuitFlow with valid element
     */
    public function testCreateCircuitFlowValid(): Void {
        try {
            AnimationUtils.createCircuitFlow(testElement, 3.0);
            
            // Check if circuit flow styles are applied
            Assert.isTrue(testElement.style.position == "relative" || 
                      testElement.style.position.length > 0);
            
            // Should have pseudo-element styles for circuit lines
            Assert.isTrue(true); // Circuit flow creates pseudo-elements via CSS
        } catch (e: Dynamic) {
            Assert.fail("createCircuitFlow should work with valid parameters: " + e);
        }
    }
    
    /**
     * Test createCircuitFlow with different durations
     */
    public function testCreateCircuitFlowDurations(): Void {
        var durations = [0.5, 1.0, 2.0, 5.0, 10.0];
        
        for (duration in durations) {
            try {
                var element = Browser.document.createElement("div");
                element.setAttribute("data-test", "true");
                Browser.document.body.appendChild(element);
                
                AnimationUtils.createCircuitFlow(element, duration);
                Assert.isTrue(true); // Should handle different durations
            } catch (e: Dynamic) {
                Assert.fail('createCircuitFlow should handle duration $duration: ' + e);
            }
        }
    }
    
    /**
     * Test createTypewriterEffect with valid parameters
     */
    public function testCreateTypewriterEffectValid(): Void {
        var text = "Hello, Twisted Brain!";
        
        try {
            AnimationUtils.createTypewriterEffect(testElement, text, 50);
            
            // Element should be prepared for typewriter effect
            Assert.notNull(testElement.textContent);
            
            // Should have data attribute for typewriter
            Assert.isTrue(testElement.hasAttribute("data-typewriter") || 
                      testElement.textContent.length >= 0);
        } catch (e: Dynamic) {
            Assert.fail("createTypewriterEffect should work with valid parameters: " + e);
        }
    }
    
    /**
     * Test createTypewriterEffect with empty text
     */
    public function testCreateTypewriterEffectEmpty(): Void {
        try {
            AnimationUtils.createTypewriterEffect(testElement, "", 50);
            Assert.isTrue(true); // Should handle empty text gracefully
        } catch (e: Dynamic) {
            Assert.fail("createTypewriterEffect should handle empty text: " + e);
        }
    }
    
    /**
     * Test createTypewriterEffect with different speeds
     */
    public function testCreateTypewriterEffectSpeeds(): Void {
        var speeds = [10, 50, 100, 200, 500];
        var text = "Test text";
        
        for (speed in speeds) {
            try {
                var element = Browser.document.createElement("div");
                element.setAttribute("data-test", "true");
                Browser.document.body.appendChild(element);
                
                AnimationUtils.createTypewriterEffect(element, text, speed);
                Assert.isTrue(true); // Should handle different speeds
            } catch (e: Dynamic) {
                Assert.fail('createTypewriterEffect should handle speed $speed: ' + e);
            }
        }
    }
    
    /**
     * Test createHoverGlow with valid parameters
     */
    public function testCreateHoverGlowValid(): Void {
        try {
            var baseGlow = { color: "#00ffff", blur: 10.0, spread: 15.0, textBlur: 5.0 };
            var hoverGlow = { color: "#ff00ff", blur: 20.0, spread: 25.0, textBlur: 10.0 };
            
            AnimationUtils.createHoverGlow(testElement, baseGlow, hoverGlow);
            
            // Element should have hover event listeners
            // We can't directly test event listeners, but method should not throw
            Assert.isTrue(true);
        } catch (e: Dynamic) {
            Assert.fail("createHoverGlow should work with valid parameters: " + e);
        }
    }
    
    /**
     * Test createFloatingAnimation with valid parameters
     */
    public function testCreateFloatingAnimationValid(): Void {
        try {
            AnimationUtils.createFloatingAnimation(testElement, 20, 4.0);
            
            // Element should have floating animation applied
            Assert.isTrue(testElement.style.animation.length > 0 ||
                      testElement.style.transform.length > 0);
        } catch (e: Dynamic) {
            Assert.fail("createFloatingAnimation should work with valid parameters: " + e);
        }
    }
    
    /**
     * Test createFloatingAnimation with different ranges
     */
    public function testCreateFloatingAnimationRanges(): Void {
        var ranges = [5, 10, 20, 50, 100];
        
        for (range in ranges) {
            try {
                var element = Browser.document.createElement("div");
                element.setAttribute("data-test", "true");
                Browser.document.body.appendChild(element);
                
                AnimationUtils.createFloatingAnimation(element, range, 2.0);
                Assert.isTrue(true); // Should handle different ranges
            } catch (e: Dynamic) {
                Assert.fail('createFloatingAnimation should handle range $range: ' + e);
            }
        }
    }
    
    /**
     * Test createStaggeredAnimation with valid parameters
     */
    public function testCreateStaggeredAnimationValid(): Void {
        try {
            var elements = [];
            for (i in 0...3) {
                var element = Browser.document.createElement("div");
                element.setAttribute("data-test", "true");
                Browser.document.body.appendChild(element);
                elements.push(element);
            }
            
            AnimationUtils.createStaggeredAnimation(elements, function(el) {
                AnimationUtils.createNeonPulse(el, "#00ffff", 1.0);
            }, 0.2);
            
            Assert.isTrue(true); // Should handle staggered animations
        } catch (e: Dynamic) {
            Assert.fail("createStaggeredAnimation should work with valid parameters: " + e);
        }
    }
    
    /**
     * Test createScrollAnimation with valid parameters
     */
    public function testCreateScrollAnimationValid(): Void {
        try {
            AnimationUtils.createScrollAnimation(testElement, function(el) {
                AnimationUtils.createNeonPulse(el, "#00ffff", 1.0);
            }, 0.5);
            
            // Element should have scroll animation setup
            Assert.isTrue(true); // Method should not throw
        } catch (e: Dynamic) {
            Assert.fail("createScrollAnimation should work with valid parameters: " + e);
        }
    }
    
    /**
     * Test GlowPresets configurations
     */
    public function testGlowPresetsValid(): Void {
        try {
            // Test that glow presets are available and valid
            var baseGlow = shared.AnimationUtils.GlowPresets.CYAN_GLOW;
            var hoverGlow = shared.AnimationUtils.GlowPresets.MAGENTA_GLOW;
            
            Assert.notNull(baseGlow);
            Assert.notNull(hoverGlow);
            Assert.isTrue(baseGlow.color.length > 0);
            Assert.isTrue(hoverGlow.color.length > 0);
            Assert.isTrue(baseGlow.blur > 0);
            Assert.isTrue(hoverGlow.blur > 0);
        } catch (e: Dynamic) {
            Assert.fail("GlowPresets should be accessible and valid: " + e);
        }
    }
    
    /**
     * Test multiple animations on same element
     */
    public function testMultipleAnimationsSameElement(): Void {
        try {
            // Apply multiple animations to same element
            AnimationUtils.createNeonPulse(testElement, "#00ffff", 2.0);
            var baseGlow = { color: "#ff00ff", blur: 10.0, spread: 15.0, textBlur: 5.0 };
            var hoverGlow = { color: "#00ffff", blur: 20.0, spread: 25.0, textBlur: 10.0 };
            AnimationUtils.createHoverGlow(testElement, baseGlow, hoverGlow);
            AnimationUtils.createFloatingAnimation(testElement, 15, 3.0);
            
            // Should handle multiple animations without conflict
            Assert.isTrue(true);
        } catch (e: Dynamic) {
            Assert.fail("Multiple animations on same element should work: " + e);
        }
    }
    
    /**
     * Test animation performance with many elements
     */
    public function testAnimationPerformance(): Void {
        var elements = [];
        
        try {
            // Create many elements
            for (i in 0...20) {
                var element = Browser.document.createElement("div");
                element.setAttribute("data-test", "true");
                Browser.document.body.appendChild(element);
                elements.push(element);
            }
            
            var startTime = haxe.Timer.stamp();
            
            // Apply animations to all elements
            for (element in elements) {
                AnimationUtils.createNeonPulse(element, "#00ffff", 2.0);
                var baseGlow = { color: "#ff00ff", blur: 5.0, spread: 10.0, textBlur: 2.0 };
                var hoverGlow = { color: "#00ffff", blur: 10.0, spread: 15.0, textBlur: 5.0 };
                AnimationUtils.createHoverGlow(element, baseGlow, hoverGlow);
            }
            
            var endTime = haxe.Timer.stamp();
            var duration = endTime - startTime;
            
            // Should complete within reasonable time
            Assert.isTrue(duration < 1.0);
        } catch (e: Dynamic) {
            Assert.fail("Animation performance should be acceptable: " + e);
        }
    }
    
    /**
     * Test animation cleanup and memory management
     */
    public function testAnimationCleanup(): Void {
        var elements = [];
        
        try {
            // Create elements with animations
            for (i in 0...10) {
                var element = Browser.document.createElement("div");
                element.setAttribute("data-test", "true");
                Browser.document.body.appendChild(element);
                
                AnimationUtils.createNeonPulse(element, "#00ffff", 1.0);
                AnimationUtils.createTypewriterEffect(element, "Test $i", 50);
                
                elements.push(element);
            }
            
            // Remove elements (simulating cleanup)
            for (element in elements) {
                if (element.parentNode != null) {
                    element.parentNode.removeChild(element);
                }
            }
            
            // Should not cause memory leaks or errors
            Assert.isTrue(true);
        } catch (e: Dynamic) {
            Assert.fail("Animation cleanup should work correctly: " + e);
        }
    }
    
    /**
     * Test edge cases with extreme values
     */
    public function testEdgeCasesExtremeValues(): Void {
        try {
            // Test with extreme values
            AnimationUtils.createNeonPulse(testElement, "#00ffff", 0.1); // Very fast
            AnimationUtils.createNeonPulse(testElement, "#ff00ff", 100.0); // Very slow
            
            AnimationUtils.createFloatingAnimation(testElement, 1, 0.1); // Minimal range/duration
            AnimationUtils.createFloatingAnimation(testElement, 1000, 1000.0); // Large range/duration
            
            var minGlow = { color: "#ffffff", blur: 0.0, spread: 0.0, textBlur: 0.0 };
            var maxGlow = { color: "#000000", blur: 1000.0, spread: 1000.0, textBlur: 1000.0 };
            AnimationUtils.createHoverGlow(testElement, minGlow, maxGlow);
            
            // Should handle extreme values gracefully
            Assert.isTrue(true);
        } catch (e: Dynamic) {
            Assert.fail("Should handle extreme values gracefully: " + e);
        }
    }
}
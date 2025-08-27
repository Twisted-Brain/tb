package shared;

/**
 * Animation utilities for creating neon-glow effects and futuristic animations.
 * Provides reusable animation functions for the Twisted Brain aesthetic.
 * 
 * This utility class handles CSS animations, transitions, and interactive
 * effects that give the landing page its distinctive cyberpunk feel.
 */
class AnimationUtils {
    
    /**
     * Create a pulsing neon glow effect
     * @param element Target element for animation
     * @param glowColor Primary glow color
     * @param duration Animation duration in seconds
     * @param intensity Glow intensity multiplier
     */
    public static function createNeonPulse(
        element: Dynamic, 
        glowColor: String, 
        duration: Float = 2.0,
        intensity: Float = 1.0
    ): Void {
        #if js
        var el = cast(element, js.html.Element);
        var keyframes = [
            {
                boxShadow: '0 0 ${10 * intensity}px $glowColor, 0 0 ${20 * intensity}px $glowColor, 0 0 ${30 * intensity}px $glowColor',
                textShadow: '0 0 ${5 * intensity}px $glowColor, 0 0 ${10 * intensity}px $glowColor'
            },
            {
                boxShadow: '0 0 ${20 * intensity}px $glowColor, 0 0 ${30 * intensity}px $glowColor, 0 0 ${40 * intensity}px $glowColor',
                textShadow: '0 0 ${10 * intensity}px $glowColor, 0 0 ${20 * intensity}px $glowColor'
            }
        ];
        
        var options = {
            duration: duration * 1000,
            iterations: js.Syntax.code("Infinity"),
            direction: js.html.PlaybackDirection.ALTERNATE,
            easing: "ease-in-out"
        };
        
        el.animate(keyframes, options);
        #end
    }
    
    /**
     * Create circuit-line flowing animation
     * @param element SVG path or line element
     * @param duration Animation duration in seconds
     * @param direction Flow direction ("forward" or "reverse")
     */
    public static function createCircuitFlow(
        element: Dynamic,
        duration: Float = 10.0,
        direction: String = "forward"
    ): Void {
        #if js
        // Handle both SVG elements and regular HTML elements
        var el: Dynamic = element;
        
        // Set up stroke-dasharray for flowing effect
        if (el.style != null) {
            el.style.strokeDasharray = "20 10";
            el.style.strokeDashoffset = direction == "forward" ? "30" : "-30";
        } else {
            // For SVG elements, set attributes directly
            el.setAttribute("stroke-dasharray", "20 10");
            el.setAttribute("stroke-dashoffset", direction == "forward" ? "30" : "-30");
        }
        
        var keyframes = [
            { strokeDashoffset: direction == "forward" ? "30" : "-30" },
            { strokeDashoffset: direction == "forward" ? "-30" : "30" }
        ];
        
        var options = {
            duration: duration * 1000,
            iterations: js.Syntax.code("Infinity"),
            easing: "linear"
        };
        
        el.animate(keyframes, options);
        #end
    }
    
    /**
     * Create typewriter effect for text elements
     * @param element Text element to animate
     * @param text Full text to type out
     * @param speed Typing speed in characters per second
     * @param onComplete Callback when animation completes
     */
    public static function createTypewriterEffect(
        element: Dynamic,
        text: String,
        speed: Float = 50.0,
        ?onComplete: Void -> Void
    ): Int {
        #if js
        var el = cast(element, js.html.Element);
        var currentIndex = 0;
        var intervalMs = Math.round(speed);
        el.textContent = "";
        
        var intervalId: Int = 0;
        intervalId = cast js.Browser.window.setInterval(function() {
            if (currentIndex < text.length) {
                el.textContent += text.charAt(currentIndex);
                currentIndex++;
            } else {
                js.Browser.window.clearInterval(cast intervalId);
                if (onComplete != null) {
                    onComplete();
                }
            }
        }, intervalMs);
        
        return intervalId;
        #else
        return 0;
        #end
    }
    
    /**
     * Create hover glow effect for interactive elements
     * @param element Target element
     * @param baseGlow Base glow configuration
     * @param hoverGlow Enhanced glow for hover state
     */
    public static function createHoverGlow(
        element: Dynamic,
        baseGlow: GlowConfig,
        hoverGlow: GlowConfig
    ): Void {
        #if js
        var el = cast(element, js.html.Element);
        
        // Set base glow
        applyGlowEffect(el, baseGlow);
        
        // Add hover listeners
        el.addEventListener("mouseenter", function(e) {
            animateGlowTransition(el, baseGlow, hoverGlow, 0.3);
        });
        
        el.addEventListener("mouseleave", function(e) {
            animateGlowTransition(el, hoverGlow, baseGlow, 0.3);
        });
        #end
    }
    
    /**
     * Apply glow effect to element
     */
    private static function applyGlowEffect(element: js.html.Element, glow: GlowConfig): Void {
        #if js
        element.style.boxShadow = '0 0 ${glow.blur}px ${glow.color}, 0 0 ${glow.spread}px ${glow.color}';
        element.style.textShadow = '0 0 ${glow.textBlur}px ${glow.color}';
        #end
    }
    
    /**
     * Animate transition between glow states
     */
    private static function animateGlowTransition(
        element: js.html.Element,
        fromGlow: GlowConfig,
        toGlow: GlowConfig,
        duration: Float
    ): Void {
        #if js
        var keyframes = [
            {
                boxShadow: '0 0 ${fromGlow.blur}px ${fromGlow.color}, 0 0 ${fromGlow.spread}px ${fromGlow.color}',
                textShadow: '0 0 ${fromGlow.textBlur}px ${fromGlow.color}'
            },
            {
                boxShadow: '0 0 ${toGlow.blur}px ${toGlow.color}, 0 0 ${toGlow.spread}px ${toGlow.color}',
                textShadow: '0 0 ${toGlow.textBlur}px ${toGlow.color}'
            }
        ];
        
        var options = {
            duration: duration * 1000,
            fill: js.html.FillMode.FORWARDS,
            easing: "ease-out"
        };
        
        element.animate(keyframes, options);
        #end
    }
    
    /**
     * Create floating animation for background elements
     * @param element Element to animate
     * @param amplitude Maximum movement distance in pixels
     * @param duration Animation cycle duration in seconds
     */
    public static function createFloatingAnimation(
        element: Dynamic,
        amplitude: Float = 20.0,
        duration: Float = 6.0
    ): Void {
        #if js
        var el = cast(element, js.html.Element);
        
        var keyframes = [
            { transform: 'translateY(0px)' },
            { transform: 'translateY(-${amplitude}px)' },
            { transform: 'translateY(0px)' },
            { transform: 'translateY(${amplitude}px)' },
            { transform: 'translateY(0px)' }
        ];
        
        var options = {
            duration: duration * 1000,
            iterations: js.Syntax.code("Infinity"),
            easing: "ease-in-out"
        };
        
        el.animate(keyframes, options);
        #end
    }
    
    /**
     * Create staggered animation for multiple elements
     * @param elements Array of elements to animate
     * @param animationFunction Function to apply to each element
     * @param staggerDelay Delay between each element's animation start
     */
    public static function createStaggeredAnimation(
        elements: Array<Dynamic>,
        animationFunction: Dynamic -> Void,
        staggerDelay: Float = 0.1
    ): Void {
        for (i in 0...elements.length) {
            var element = elements[i];
            var delay = i * staggerDelay * 1000;
            
            #if js
            js.Browser.window.setTimeout(function() {
                animationFunction(element);
            }, Math.round(delay));
            #else
            animationFunction(element);
            #end
        }
    }
    
    /**
     * Create scroll-triggered animation
     * @param element Element to animate when in view
     * @param animationFunction Animation to trigger
     * @param threshold Percentage of element that must be visible (0.0 to 1.0)
     */
    public static function createScrollAnimation(
        element: Dynamic,
        animationFunction: Dynamic -> Void,
        threshold: Float = 0.3
    ): Void {
        #if js
        var el = cast(element, js.html.Element);
        
        var observer = new js.html.IntersectionObserver(function(entries, observer) {
            for (entry in entries) {
                if (entry.isIntersecting) {
                    animationFunction(entry.target);
                    observer.unobserve(entry.target);
                }
            }
        }, {
            threshold: threshold
        });
        
        observer.observe(el);
        #end
    }
}

/**
 * Configuration for glow effects
 */
typedef GlowConfig = {
    color: String,
    blur: Float,
    spread: Float,
    textBlur: Float
}

/**
 * Predefined glow configurations for common use cases
 */
class GlowPresets {
    public static var CYAN_GLOW: GlowConfig = {
        color: "#00FFFF",
        blur: 15.0,
        spread: 25.0,
        textBlur: 8.0
    };
    
    public static var MAGENTA_GLOW: GlowConfig = {
        color: "#FF00FF",
        blur: 15.0,
        spread: 25.0,
        textBlur: 8.0
    };
    
    public static var ORANGE_GLOW: GlowConfig = {
        color: "#FF8C00",
        blur: 15.0,
        spread: 25.0,
        textBlur: 8.0
    };
    
    public static var SUBTLE_CYAN: GlowConfig = {
        color: "#00FFFF",
        blur: 8.0,
        spread: 12.0,
        textBlur: 4.0
    };
    
    public static var INTENSE_MAGENTA: GlowConfig = {
        color: "#FF00FF",
        blur: 25.0,
        spread: 35.0,
        textBlur: 15.0
    };
}
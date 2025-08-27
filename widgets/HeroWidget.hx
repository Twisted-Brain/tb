package widgets;

import domain.LandingPageData.HeroConfiguration;
import js.Browser;
import js.html.Element;

/**
 * Reusable Hero section widget for the Twisted Brain landing page.
 * Handles rendering and interactions for the hero section with neon aesthetics.
 * 
 * This widget encapsulates the hero section's visual presentation,
 * animations, and user interactions in a self-contained, reusable component.
 */
class HeroWidget {
    
    private var configuration: HeroConfiguration;
    private var containerElement: Element;
    private var isRendered: Bool = false;
    
    /**
     * Create a new hero widget instance
     */
    public function new(config: HeroConfiguration) {
        configuration = config;
    }
    
    /**
     * Render the hero widget and return the DOM element
     */
    public function render(): Element {
        if (isRendered && containerElement != null) {
            return containerElement;
        }
        
        containerElement = createHeroElement();
        isRendered = true;
        
        return containerElement;
    }
    
    /**
     * Create the main hero section element
     */
    private function createHeroElement(): Element {
        var section = Browser.document.createElement("section");
        section.id = "hero";
        section.className = "hero-section neon-background";
        
        // Create container
        var container = Browser.document.createDivElement();
        container.className = "hero-container";
        
        // Add content
        container.appendChild(createHeroContent());
        container.appendChild(createHeroBackground());
        
        section.appendChild(container);
        
        return section;
    }
    
    /**
     * Create the hero content area
     */
    private function createHeroContent(): Element {
        var content = Browser.document.createDivElement();
        content.className = "hero-content";
        
        // Add logos
        content.appendChild(createLogosSection());
        
        // Add headline
        var headline = Browser.document.createHeadingElement(1);
        headline.className = "hero-headline neon-text-cyan";
        headline.textContent = configuration.headline;
        content.appendChild(headline);
        
        // Add subtext
        var subtext = Browser.document.createParagraphElement();
        subtext.className = "hero-subtext";
        subtext.textContent = configuration.subtext;
        content.appendChild(subtext);
        
        // Add CTAs
        content.appendChild(createCtaSection());
        
        return content;
    }
    
    /**
     * Create the logos section
     */
    private function createLogosSection(): Element {
        var logosContainer = Browser.document.createDivElement();
        logosContainer.className = "hero-logos";
        
        // Left logo
        var leftLogo = Browser.document.createImageElement();
        leftLogo.src = configuration.logoLeft;
        leftLogo.alt = "Twisted Brain Logo";
        leftLogo.className = "logo-left neon-glow-cyan";
        logosContainer.appendChild(leftLogo);
        
        // Right logo
        var rightLogo = Browser.document.createImageElement();
        rightLogo.src = configuration.logoRight;
        rightLogo.alt = "Haxe DevOps Logo";
        rightLogo.className = "logo-right neon-glow-orange";
        logosContainer.appendChild(rightLogo);
        
        return logosContainer;
    }
    
    /**
     * Create the CTA buttons section
     */
    private function createCtaSection(): Element {
        var ctaContainer = Browser.document.createDivElement();
        ctaContainer.className = "hero-ctas";
        
        // Primary CTA
        var primaryCta = Browser.document.createAnchorElement();
        primaryCta.href = configuration.primaryCta.url;
        primaryCta.className = 'cta-button ${configuration.primaryCta.style}';
        primaryCta.textContent = configuration.primaryCta.text;
        ctaContainer.appendChild(primaryCta);
        
        // Secondary CTA
        var secondaryCta = Browser.document.createAnchorElement();
        secondaryCta.href = configuration.secondaryCta.url;
        secondaryCta.className = 'cta-button ${configuration.secondaryCta.style}';
        secondaryCta.textContent = configuration.secondaryCta.text;
        secondaryCta.target = "_blank";
        ctaContainer.appendChild(secondaryCta);
        
        return ctaContainer;
    }
    
    /**
     * Create the animated background
     */
    private function createHeroBackground(): Element {
        var background = Browser.document.createDivElement();
        background.className = "hero-background";
        
        // Create SVG circuit lines
        var svg = Browser.document.createElementNS("http://www.w3.org/2000/svg", "svg");
        svg.setAttribute("class", "circuit-lines");
        svg.setAttribute("viewBox", "0 0 1200 800");
        
        // Circuit paths
        var paths = [
            {d: "M0,400 Q300,200 600,400 T1200,400", className: "circuit-path cyan"},
            {d: "M0,300 Q400,100 800,300 T1200,300", className: "circuit-path magenta"},
            {d: "M0,500 Q200,700 400,500 T800,500 Q1000,300 1200,500", className: "circuit-path orange"}
        ];
        
        for (pathData in paths) {
            var path = Browser.document.createElementNS("http://www.w3.org/2000/svg", "path");
            path.setAttribute("class", pathData.className);
            path.setAttribute("d", pathData.d);
            svg.appendChild(path);
        }
        
        background.appendChild(svg);
        
        return background;
    }
    
    /**
     * Initialize hero-specific animations and interactions
     */
    public function initializeAnimations(): Void {
        if (!isRendered || containerElement == null) return;
        
        // Pulse animation for headline
        var headline = containerElement.querySelector(".hero-headline");
        if (headline != null) {
            addPulseAnimation(headline);
        }
        
        // Floating animation for logos
        var logos = containerElement.querySelectorAll(".logo-left, .logo-right");
        for (i in 0...logos.length) {
            addFloatingAnimation(logos[i]);
        }
        
        // Circuit flow animations
        var circuitPaths = containerElement.querySelectorAll(".circuit-path");
        for (i in 0...circuitPaths.length) {
            addCircuitFlowAnimation(circuitPaths[i], i);
        }
        
        // CTA hover effects
        var ctaButtons = containerElement.querySelectorAll(".cta-button");
        for (i in 0...ctaButtons.length) {
            addCtaHoverEffect(ctaButtons[i]);
        }
    }
    
    /**
     * Add pulse animation to an element
     */
    private function addPulseAnimation(element: Element): Void {
        var htmlElement = cast(element, js.html.Element);
        htmlElement.style.animation = "pulse 3s ease-in-out infinite";
    }
    
    /**
     * Add floating animation to an element
     */
    private function addFloatingAnimation(element: Element): Void {
        var htmlElement = cast(element, js.html.Element);
        
        htmlElement.addEventListener("mouseenter", function(e) {
            htmlElement.style.transform = "scale(1.1) translateY(-5px)";
            htmlElement.style.transition = "transform 0.3s ease";
        });
        
        htmlElement.addEventListener("mouseleave", function(e) {
            htmlElement.style.transform = "scale(1) translateY(0)";
        });
    }
    
    /**
     * Add circuit flow animation to path elements
     */
    private function addCircuitFlowAnimation(element: Element, index: Int): Void {
        var pathElement = cast(element, js.html.Element);
        pathElement.style.strokeDasharray = "10 5";
        pathElement.style.animation = 'circuit-flow ${8 + (index * 2)}s linear infinite';
    }
    
    /**
     * Add hover effects to CTA buttons
     */
    private function addCtaHoverEffect(element: Element): Void {
        var buttonElement = cast(element, js.html.Element);
        
        buttonElement.addEventListener("mouseenter", function(e) {
            if (buttonElement.classList.contains("primary-neon")) {
                buttonElement.style.transform = "translateY(-2px)";
                buttonElement.style.boxShadow = "0 0 30px var(--glow-cyan), 0 5px 15px rgba(0, 255, 255, 0.3)";
            } else if (buttonElement.classList.contains("secondary-outline")) {
                buttonElement.style.backgroundColor = "var(--glow-cyan)";
                buttonElement.style.color = "var(--color-dark)";
                buttonElement.style.transform = "translateY(-2px)";
            }
        });
        
        buttonElement.addEventListener("mouseleave", function(e) {
            buttonElement.style.transform = "translateY(0)";
            
            if (buttonElement.classList.contains("primary-neon")) {
                buttonElement.style.boxShadow = "0 0 20px var(--glow-cyan)";
            } else if (buttonElement.classList.contains("secondary-outline")) {
                buttonElement.style.backgroundColor = "transparent";
                buttonElement.style.color = "var(--color-cyan)";
            }
        });
    }
    
    /**
     * Update the hero configuration and re-render if needed
     */
    public function updateConfiguration(newConfig: HeroConfiguration): Void {
        configuration = newConfig;
        
        if (isRendered && containerElement != null) {
            // Update existing elements instead of full re-render
            updateExistingElements();
        }
    }
    
    /**
     * Update existing DOM elements with new configuration
     */
    private function updateExistingElements(): Void {
        // Update headline
        var headline = containerElement.querySelector(".hero-headline");
        if (headline != null) {
            headline.textContent = configuration.headline;
        }
        
        // Update subtext
        var subtext = containerElement.querySelector(".hero-subtext");
        if (subtext != null) {
            subtext.textContent = configuration.subtext;
        }
        
        // Update logos
        var leftLogo = cast(containerElement.querySelector(".logo-left"), js.html.ImageElement);
        if (leftLogo != null) {
            leftLogo.src = configuration.logoLeft;
        }
        
        var rightLogo = cast(containerElement.querySelector(".logo-right"), js.html.ImageElement);
        if (rightLogo != null) {
            rightLogo.src = configuration.logoRight;
        }
        
        // Update CTAs
        var primaryCta = cast(containerElement.querySelector(".cta-button.primary-neon"), js.html.AnchorElement);
        if (primaryCta != null) {
            primaryCta.href = configuration.primaryCta.url;
            primaryCta.textContent = configuration.primaryCta.text;
        }
        
        var secondaryCta = cast(containerElement.querySelector(".cta-button.secondary-outline"), js.html.AnchorElement);
        if (secondaryCta != null) {
            secondaryCta.href = configuration.secondaryCta.url;
            secondaryCta.textContent = configuration.secondaryCta.text;
        }
    }
    
    /**
     * Get the current configuration
     */
    public function getConfiguration(): HeroConfiguration {
        return configuration;
    }
    
    /**
     * Check if the widget has been rendered
     */
    public function isWidgetRendered(): Bool {
        return isRendered;
    }
    
    /**
     * Get the container element (null if not rendered)
     */
    public function getElement(): Element {
        return containerElement;
    }
    
    /**
     * Destroy the widget and clean up event listeners
     */
    public function destroy(): Void {
        if (containerElement != null && containerElement.parentNode != null) {
            containerElement.parentNode.removeChild(containerElement);
        }
        
        containerElement = null;
        isRendered = false;
    }
}
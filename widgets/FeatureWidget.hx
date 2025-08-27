package widgets;

import domain.LandingPageData.FeatureConfiguration;
import js.Browser;
import js.html.Element;

/**
 * Reusable Feature section widget for the Twisted Brain landing page.
 * Handles rendering and interactions for individual feature cards with neon styling.
 * 
 * This widget creates interactive feature cards with hover effects,
 * neon borders, and smooth animations for enhanced user experience.
 */
class FeatureWidget {
    
    private var features: Array<FeatureConfiguration>;
    private var containerElement: Element;
    private var isRendered: Bool = false;
    
    /**
     * Create a new feature widget instance
     */
    public function new(featureList: Array<FeatureConfiguration>) {
        features = featureList;
    }
    
    /**
     * Render the features section and return the DOM element
     */
    public function render(): Element {
        if (isRendered && containerElement != null) {
            return containerElement;
        }
        
        containerElement = createFeaturesSection();
        isRendered = true;
        
        return containerElement;
    }
    
    /**
     * Create the main features section element
     */
    private function createFeaturesSection(): Element {
        var section = Browser.document.createElement("section");
        section.id = "features";
        section.className = "features-section";
        
        // Create container
        var container = Browser.document.createDivElement();
        container.className = "section-container";
        
        // Add section title
        var title = Browser.document.createHeadingElement(2);
        title.className = "section-title neon-text-orange";
        title.textContent = "Key Features";
        container.appendChild(title);
        
        // Create features grid
        var grid = Browser.document.createDivElement();
        grid.className = "features-grid";
        
        // Add feature cards
        for (feature in features) {
            grid.appendChild(createFeatureCard(feature));
        }
        
        container.appendChild(grid);
        section.appendChild(container);
        
        return section;
    }
    
    /**
     * Create an individual feature card
     */
    private function createFeatureCard(feature: FeatureConfiguration): Element {
        var card = Browser.document.createDivElement();
        card.className = 'feature-card neon-border-${feature.iconColor}';
        
        // Feature icon
        var icon = Browser.document.createDivElement();
        icon.className = 'feature-icon ${feature.icon} ${feature.iconColor}';
        card.appendChild(icon);
        
        // Feature title
        var title = Browser.document.createHeadingElement(3);
        title.className = "feature-title";
        title.textContent = feature.title;
        card.appendChild(title);
        
        // Feature description
        var description = Browser.document.createParagraphElement();
        description.className = "feature-description";
        description.textContent = feature.description;
        card.appendChild(description);
        
        return card;
    }
    
    /**
     * Initialize feature-specific animations and interactions
     */
    public function initializeAnimations(): Void {
        if (!isRendered || containerElement == null) return;
        
        var featureCards = containerElement.querySelectorAll(".feature-card");
        
        // Add staggered entrance animations
        for (i in 0...featureCards.length) {
            var card = cast(featureCards[i], js.html.Element);
            
            // Initial state for animation
            card.style.opacity = "0";
            card.style.transform = "translateY(50px)";
            card.style.transition = "all 0.6s ease";
            
            // Trigger animation with delay
            Browser.window.setTimeout(function() {
                addScrollTriggeredAnimation(card);
            }, i * 200);
            
            // Add hover effects
            addFeatureCardHoverEffect(card);
        }
    }
    
    /**
     * Add scroll-triggered animation to a feature card
     */
    private function addScrollTriggeredAnimation(card: js.html.Element): Void {
        var observer = new js.html.IntersectionObserver(function(entries, observer) {
            for (entry in entries) {
                if (entry.isIntersecting) {
                    var element = cast(entry.target, js.html.Element);
                    element.style.opacity = "1";
                    element.style.transform = "translateY(0)";
                    observer.unobserve(element);
                }
            }
        }, {
            threshold: 0.1,
            rootMargin: "0px 0px -50px 0px"
        });
        
        observer.observe(card);
    }
    
    /**
     * Add hover effects to feature cards
     */
    private function addFeatureCardHoverEffect(card: js.html.Element): Void {
        card.addEventListener("mouseenter", function(e) {
            card.style.transform = "translateY(-10px)";
            
            // Enhance glow effect based on card type
            if (card.classList.contains("neon-border-cyan-magenta")) {
                card.style.boxShadow = "0 0 30px var(--glow-cyan), 0 10px 20px rgba(0, 255, 255, 0.2)";
            } else if (card.classList.contains("neon-border-orange-glow")) {
                card.style.boxShadow = "0 0 30px var(--glow-orange), 0 10px 20px rgba(255, 165, 0, 0.2)";
            } else if (card.classList.contains("neon-border-purple-cyan")) {
                card.style.boxShadow = "0 0 30px var(--glow-purple), 0 10px 20px rgba(255, 0, 255, 0.2)";
            }
            
            // Animate icon
            var icon = card.querySelector(".feature-icon");
            if (icon != null) {
                var iconElement = cast(icon, js.html.Element);
                iconElement.style.transform = "scale(1.1) rotate(5deg)";
                iconElement.style.transition = "transform 0.3s ease";
            }
        });
        
        card.addEventListener("mouseleave", function(e) {
            card.style.transform = "translateY(0)";
            
            // Reset glow effect
            if (card.classList.contains("neon-border-cyan-magenta")) {
                card.style.boxShadow = "0 0 20px var(--glow-cyan)";
            } else if (card.classList.contains("neon-border-orange-glow")) {
                card.style.boxShadow = "0 0 20px var(--glow-orange)";
            } else if (card.classList.contains("neon-border-purple-cyan")) {
                card.style.boxShadow = "0 0 20px var(--glow-purple)";
            }
            
            // Reset icon
            var icon = card.querySelector(".feature-icon");
            if (icon != null) {
                var iconElement = cast(icon, js.html.Element);
                iconElement.style.transform = "scale(1) rotate(0deg)";
            }
        });
    }
    
    /**
     * Add a new feature to the widget
     */
    public function addFeature(feature: FeatureConfiguration): Void {
        features.push(feature);
        
        if (isRendered && containerElement != null) {
            var grid = containerElement.querySelector(".features-grid");
            if (grid != null) {
                var newCard = createFeatureCard(feature);
                grid.appendChild(newCard);
                
                // Initialize animations for the new card
                var cardElement = cast(newCard, js.html.Element);
                cardElement.style.opacity = "0";
                cardElement.style.transform = "translateY(50px)";
                cardElement.style.transition = "all 0.6s ease";
                
                Browser.window.setTimeout(function() {
                    addScrollTriggeredAnimation(cardElement);
                    addFeatureCardHoverEffect(cardElement);
                }, 100);
            }
        }
    }
    
    /**
     * Remove a feature by index
     */
    public function removeFeature(index: Int): Bool {
        if (index < 0 || index >= features.length) {
            return false;
        }
        
        features.splice(index, 1);
        
        if (isRendered && containerElement != null) {
            var grid = containerElement.querySelector(".features-grid");
            if (grid != null && grid.children.length > index) {
                var cardToRemove = grid.children[index];
                
                // Animate out
                var cardElement = cast(cardToRemove, js.html.Element);
                cardElement.style.opacity = "0";
                cardElement.style.transform = "translateY(-50px)";
                
                Browser.window.setTimeout(function() {
                    if (cardToRemove.parentNode != null) {
                        cardToRemove.parentNode.removeChild(cardToRemove);
                    }
                }, 600);
            }
        }
        
        return true;
    }
    
    /**
     * Update a feature by index
     */
    public function updateFeature(index: Int, newFeature: FeatureConfiguration): Bool {
        if (index < 0 || index >= features.length) {
            return false;
        }
        
        features[index] = newFeature;
        
        if (isRendered && containerElement != null) {
            var grid = containerElement.querySelector(".features-grid");
            if (grid != null && grid.children.length > index) {
                var oldCard = grid.children[index];
                var newCard = createFeatureCard(newFeature);
                
                // Replace with animation
                var oldCardElement = cast(oldCard, js.html.Element);
                oldCardElement.style.opacity = "0";
                oldCardElement.style.transform = "scale(0.8)";
                
                Browser.window.setTimeout(function() {
                    grid.replaceChild(newCard, oldCard);
                    
                    var newCardElement = cast(newCard, js.html.Element);
                    newCardElement.style.opacity = "0";
                    newCardElement.style.transform = "scale(0.8)";
                    newCardElement.style.transition = "all 0.6s ease";
                    
                    Browser.window.setTimeout(function() {
                        newCardElement.style.opacity = "1";
                        newCardElement.style.transform = "scale(1)";
                        addFeatureCardHoverEffect(newCardElement);
                    }, 50);
                }, 300);
            }
        }
        
        return true;
    }
    
    /**
     * Get all features
     */
    public function getFeatures(): Array<FeatureConfiguration> {
        return features.copy();
    }
    
    /**
     * Get a specific feature by index
     */
    public function getFeature(index: Int): FeatureConfiguration {
        if (index < 0 || index >= features.length) {
            return null;
        }
        return features[index];
    }
    
    /**
     * Get the number of features
     */
    public function getFeatureCount(): Int {
        return features.length;
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
     * Refresh the entire features section
     */
    public function refresh(): Void {
        if (isRendered && containerElement != null) {
            var parent = containerElement.parentNode;
            if (parent != null) {
                var newElement = createFeaturesSection();
                parent.replaceChild(newElement, containerElement);
                containerElement = newElement;
                initializeAnimations();
            }
        }
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
        features = [];
    }
}
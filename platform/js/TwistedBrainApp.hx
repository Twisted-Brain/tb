package platform.js;

import js.Browser;
import js.html.Element;

/**
 * Ultra-simple Twisted Brain landing page - everything in one file
 */
class TwistedBrainApp {
    
    public static function main(): Void {
        Browser.document.addEventListener("DOMContentLoaded", function() {
            renderPage();
        });
    }
    
    private static function renderPage(): Void {
        var body = Browser.document.body;
        body.innerHTML = '
            <div class="app-container">
                <!-- Hero Section -->
                <section id="hero" class="hero-section">
                    <div class="hero-container">
                        <div class="hero-content">
                            <div class="hero-logo">
                                <img src="assets/logo.png" alt="Twisted Brain Logo" class="main-logo" />
                            </div>
                            <h1 class="hero-headline">AI + Human: The Future of DevOps</h1>
                            <p class="hero-subtext">Bridging code, AI agents, and human creativity to build, test, and scale with Haxe. Experience the next generation of development workflows where artificial intelligence amplifies human potential.</p>
                            <div class="hero-ctas">
                                <a href="#features" class="cta-button cta-primary">Get Started</a>
                                <a href="https://github.com/twisted-brain/tb-pages" class="cta-button cta-secondary" target="_blank">View on GitHub</a>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- About Section -->
                <section id="about" class="about-section">
                    <div class="section-container">
                        <div class="about-content">
                            <div class="about-logo">
                                <img src="assets/tb_3.png" alt="Twisted Brain" />
                            </div>
                            <div class="about-text">
                                <h2 class="section-tagline">We are developers shaping the future with Haxe and AI.</h2>
                                <p class="about-description">Twisted Brain pioneers AI-assisted development for multi-target Haxe projects. Our platform enables seamless human-AI collaboration in DevOps cycles: code → test → validate → deploy.</p>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- Features Section -->
                <section id="features" class="features-section">
                    <div class="section-container">
                        <h2 class="section-title">Key Features</h2>
                        <div class="features-grid">
                            <div class="feature-card">
                                <div class="feature-icon">🤖</div>
                                <h3 class="feature-title">AI DevOps Pipeline</h3>
                                <p class="feature-description">Automates repetitive coding and testing tasks with intelligent agents that learn from your patterns and preferences.</p>
                            </div>
                            <div class="feature-card">
                                <div class="feature-icon">🎯</div>
                                <h3 class="feature-title">Multi-Target Haxe Development</h3>
                                <p class="feature-description">Compile once, run everywhere. Deploy to JavaScript, C++, Java, PHP, Lua, and more from a single codebase.</p>
                            </div>
                            <div class="feature-card">
                                <div class="feature-icon">🧠</div>
                                <h3 class="feature-title">Human + AI Collaboration</h3>
                                <p class="feature-description">AI proposes solutions, humans refine and perfect them. Balance efficiency with creativity for optimal results.</p>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- Community Section -->
                <section id="community" class="community-section">
                    <div class="section-container">
                        <h2 class="community-statement">Twisted Brain is open-source, transparent, and community-driven.</h2>
                        <p class="community-description">Join our growing community of developers pushing the boundaries of AI-assisted development.</p>
                        <div class="community-ctas">
                            <a href="https://github.com/twisted-brain" class="cta-button cta-primary" target="_blank">Contribute on GitHub</a>
                        </div>
                    </div>
                </section>
                
                <!-- Footer Section -->
                <footer id="footer" class="footer-section">
                    <div class="footer-container">
                        <div class="footer-logos">
                            <img src="assets/tb.png" alt="Twisted Brain" class="footer-logo" />
                            <img src="assets/hdevm_1.png" alt="DevOps" class="footer-devops-logo" />
                        </div>
                        <div class="footer-links">
                            <div class="link-group">
                                <h4>Project</h4>
                                <a href="https://github.com/twisted-brain/tb-pages" target="_blank">GitHub</a>
                                <a href="#docs">Documentation</a>
                                <a href="#roadmap">Roadmap</a>
                            </div>
                            <div class="link-group">
                                <h4>Community</h4>
                                <a href="https://github.com/twisted-brain/tb-pages/contribute" target="_blank">Contribute</a>
                                <a href="https://github.com/twisted-brain/tb-pages/issues" target="_blank">Issues</a>
                                <a href="#contact">Contact</a>
                            </div>
                        </div>
                        <div class="footer-bottom">
                            <p class="copyright">© 2024 Twisted Brain. Open source under MIT License.</p>
                            <p class="haxe-credit">Built with Haxe - The Cross-Platform Toolkit</p>
                        </div>
                    </div>
                </footer>
            </div>
        ';
    }
}
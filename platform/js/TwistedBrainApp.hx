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
                                <a href="#features" class="cta-button primary-neon">Get Started</a>
                                <a href="https://github.com/twisted-brain/tb-pages" class="cta-button secondary-outline" target="_blank">View on GitHub</a>
                            </div>
                        </div>
                        <div class="hero-background">
                            <svg class="circuit-lines" viewBox="0 0 1200 800">
                                <path class="circuit-path cyan" d="M0,100 Q300,50 600,100 T1200,100" />
                                <path class="circuit-path magenta" d="M0,300 Q400,250 800,300 T1200,300" />
                                <path class="circuit-path orange" d="M0,500 Q200,450 400,500 T1200,500" />
                                <path class="circuit-path cyan" d="M100,0 Q150,200 200,400 T300,800" />
                                <path class="circuit-path magenta" d="M500,0 Q550,300 600,600 T700,800" />
                                <path class="circuit-path orange" d="M900,0 Q950,250 1000,500 T1100,800" />
                            </svg>
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
                        <h2 class="section-title neon-text-orange">Key Features</h2>
                        <div class="features-grid">
                            <div class="feature-card neon-border-cyan-magenta">
                                <div class="feature-icon cyan-magenta">🤖🔗</div>
                                <h3 class="feature-title neon-text-cyan">AI DevOps Pipeline</h3>
                                <p class="feature-description">Automates repetitive coding and testing tasks with intelligent agents that learn from your patterns and preferences. Circuit + brain intelligence working together.</p>
                            </div>
                            <div class="feature-card neon-border-orange-glow">
                                <div class="feature-icon orange-glow">⚡</div>
                                <h3 class="feature-title neon-text-orange">Multi-Target Haxe Development</h3>
                                <p class="feature-description">Compile once, run everywhere. Deploy to JavaScript, C++, Java, PHP, Lua, and more from a single codebase. The glowing orange Haxe X powers it all.</p>
                            </div>
                            <div class="feature-card neon-border-purple-cyan">
                                <div class="feature-icon purple-cyan">🧠⚡</div>
                                <h3 class="feature-title neon-text-magenta">Human + AI Collaboration</h3>
                                <p class="feature-description">AI proposes solutions, humans refine and perfect them. Two halves of the Twisted Brain working in perfect harmony to balance efficiency with creativity.</p>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- Showcase / Demo Section -->
                <section id="showcase" class="showcase-section">
                    <div class="section-container">
                        <h2 class="section-title neon-text-blue">Showcase & Demo</h2>
                        <div class="mockups-container">
                            <div class="mockup-item">
                                <div class="mockup-image">
                                    <div class="mockup-placeholder">HaxeUI PoC</div>
                                    <a href="https://github.com/Twisted-Brain/HaxeUI-PoC.git" target="_blank">View Project</a>
                                </div>
                                <p class="mockup-description">HaxeUI Proof of Concept with DOM and OpenFL versions</p>
                            </div>
                            <div class="mockup-item">
                                <div class="mockup-image">
                                    <div class="mockup-placeholder">Haxe HexArc</div>
                                    <a href="https://github.com/Twisted-Brain/PoC-Haxe-HexArc.git" target="_blank">View Project</a>
                                </div>
                                <p class="mockup-description">Multi-Platform AI Application with Hexagonal Architecture</p>
                            </div>
                        </div>
                        <div class="code-cycle">
                            <h3 class="cycle-title">AI-Assisted Development Cycle</h3>
                            <div class="cycle-steps">
                                <div class="cycle-step">
                                    <span class="step-text neon-border-cyan-magenta">Code</span>
                                    <span class="step-arrow">→</span>
                                </div>
                                <div class="cycle-step">
                                    <span class="step-text neon-border-orange-glow">Test</span>
                                    <span class="step-arrow">→</span>
                                </div>
                                <div class="cycle-step">
                                    <span class="step-text neon-border-purple-cyan">Fix</span>
                                    <span class="step-arrow">→</span>
                                </div>
                                <div class="cycle-step">
                                    <span class="step-text neon-border-cyan-magenta">Deploy</span>
                                    <span class="step-arrow">→</span>
                                </div>
                                <div class="cycle-step">
                                    <span class="step-text neon-border-orange-glow">Repeat</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- Community Section -->
                <section id="community" class="community-section">
                    <div class="section-container">
                        <h2 class="community-statement neon-text-magenta">Twisted Brain is open-source, transparent, and community-driven.</h2>
                        <p class="community-description">Join our growing community of developers pushing the boundaries of AI-assisted development.</p>
                        <div class="community-actions">
                            <div class="cta-button">Contribute on GitHub</div>
                        </div>
                        <div class="social-links">
                            <div class="social-link">
                                <span class="social-icon">📚</span>
                                <span class="social-text">Documentation</span>
                            </div>
                            <div class="social-link">
                                <span class="social-icon">💬</span>
                                <span class="social-text">Discord</span>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- Footer Section -->
                <footer id="footer" class="footer-section neon-border-top">
                    <div class="footer-container">
                        <div class="footer-content">
                            <div class="footer-branding">
                                <img src="assets/tb.png" alt="Twisted Brain" class="footer-logo neon-glow-cyan" />
                                <img src="assets/hdevm_1.png" alt="Haxe DevOps Project" class="devops-logo neon-glow-orange" />
                            </div>
                            <div class="footer-links">
                                <div class="link-category">
                                    <h4 class="category-title neon-text-cyan">Project</h4>
                                    <ul class="category-links">
                                        <li><a href="https://github.com/twisted-brain/tb-pages" class="footer-link" target="_blank">GitHub</a></li>
                                        <li><a href="#docs" class="footer-link">Documentation</a></li>
                                        <li><a href="#roadmap" class="footer-link">Roadmap</a></li>
                                        <li><a href="#contact" class="footer-link">Contact</a></li>
                                    </ul>
                                </div>
                                <div class="link-category">
                                    <h4 class="category-title neon-text-orange">Community</h4>
                                    <ul class="category-links">
                                        <li><a href="https://github.com/twisted-brain/tb-pages/contribute" class="footer-link" target="_blank">Contribute</a></li>
                                        <li><a href="https://github.com/twisted-brain/tb-pages/issues" class="footer-link" target="_blank">Issues</a></li>
                                        <li><a href="#discord" class="footer-link">Discord</a></li>
                                        <li><a href="#support" class="footer-link">Support</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="footer-bottom">
                            <p class="copyright">© 2024 Twisted Brain. Open source under MIT License.</p>
                            <p class="haxe-credit neon-text-orange">Built with Haxe - The Cross-Platform Toolkit</p>
                        </div>
                    </div>
                </footer>
            </div>
        ';
    }
}
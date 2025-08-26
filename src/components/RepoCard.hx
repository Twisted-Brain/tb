package components;

import react.React;
import react.ReactComponent;
import react.ReactMacro.jsx;
import services.GitHubApiService.GitHubRepository;
import css.RepoCardCss;

@:css(RepoCardCss.use)
class RepoCard extends ReactComponent {
    @:prop var repository: GitHubRepository;
    
    override function render() {
        var repo = props.repository;
        var description = repo.description != null ? repo.description : "No description available";
        var language = repo.language != null ? repo.language : "Unknown";
        
        return jsx('
            <div className="repo-card">
                <div className="repo-header">
                    <h3 className="repo-name">
                        <a href="${repo.html_url}" target="_blank" rel="noopener noreferrer">
                            ${repo.name}
                        </a>
                    </h3>
                    <span className="repo-stars">⭐ ${repo.stargazers_count}</span>
                </div>
                <p className="repo-description">${description}</p>
                <div className="repo-footer">
                    <span className="repo-language">${language}</span>
                    <span className="repo-updated">Updated: ${formatDate(repo.updated_at)}</span>
                </div>
            </div>
        ');
    }
    
    private function formatDate(dateString: String): String {
        var date = new js.lib.Date(dateString);
        return date.toLocaleDateString();
    }
}
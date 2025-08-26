package components;

import react.React;
import react.ReactComponent;
import react.ReactMacro.jsx;
import css.RepoListCss;
import components.RepoCard;
import services.GitHubApiService;
import services.GitHubApiService.GitHubRepository;

@:css(RepoListCss.use)
class RepoList extends ReactComponent {
    @:state var repositories: Array<GitHubRepository> = [];
    @:state var loading: Bool = true;
    @:state var error: String = null;
    
    override function componentDidMount() {
        loadRepositories();
    }
    
    private function loadRepositories() {
        setState({loading: true, error: null});
        
        GitHubApiService.getUserRepositories("twistedbrain")
            .then(function(repos) {
                setState({repositories: repos, loading: false});
            })
            .catchError(function(err) {
                setState({error: "Failed to load repositories: " + err, loading: false});
            });
    }
    
    override function render() {
        if (state.loading) {
            return jsx('
                <div className="repo-list">
                    <div className="loading">Loading repositories...</div>
                </div>
            ');
        }
        
        if (state.error != null) {
            return jsx('
                <div className="repo-list">
                    <div className="error">${state.error}</div>
                    <button onClick=${function(_) loadRepositories()}>Retry</button>
                </div>
            ');
        }
        
        return jsx('
            <div className="repo-list">
                <h2>Latest Repositories</h2>
                <div className="repo-grid">
                    ${state.repositories.map(function(repo) {
                        return jsx('<RepoCard key=${repo.id} repository=${repo} />');
                    })}
                </div>
            </div>
        ');
    }
}
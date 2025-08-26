package services;

import js.lib.Promise;
import haxe.Json;
import haxe.Http;

typedef GitHubRepository = {
    var id: Int;
    var name: String;
    var full_name: String;
    var description: String;
    var html_url: String;
    var stargazers_count: Int;
    var language: String;
    var updated_at: String;
}

class GitHubApiService {
    private static inline var BASE_URL = "https://api.github.com";
    
    public static function getUserRepositories(username: String): Promise<Array<GitHubRepository>> {
        return new Promise(function(resolve, reject) {
            var http = new Http('$BASE_URL/users/$username/repos?sort=updated&per_page=10');
            
            http.onData = function(data: String) {
                try {
                    var repos: Array<GitHubRepository> = Json.parse(data);
                    resolve(repos);
                } catch (e: Dynamic) {
                    reject(e);
                }
            };
            
            http.onError = function(error: String) {
                reject(error);
            };
            
            http.request();
        });
    }
    
    public static function getOrganizationRepositories(org: String): Promise<Array<GitHubRepository>> {
        return new Promise(function(resolve, reject) {
            var http = new Http('$BASE_URL/orgs/$org/repos?sort=updated&per_page=10');
            
            http.onData = function(data: String) {
                try {
                    var repos: Array<GitHubRepository> = Json.parse(data);
                    resolve(repos);
                } catch (e: Dynamic) {
                    reject(e);
                }
            };
            
            http.onError = function(error: String) {
                reject(error);
            };
            
            http.request();
        });
    }
}
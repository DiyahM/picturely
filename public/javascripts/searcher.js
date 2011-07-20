/*
 * searcher.js
 *
 * Base class for Twitter image source searchers.  Subclasses know how
 * to search for Instagram, Yfrog, Twitpic, etc image sources.
 */

var Searcher = Class.$extend({
    __init__ : function() {
        this.providers = [];
        this.pause = 600;       // milliseconds

        // paging
        this.per_page = 100;
    },

    addProvider : function(provider) {
        this.providers.push(provider);
    },

    buildQuery : function(term, since_id) {
        // query data object to return
        var retval = {}

	// optional since_id
	if (since_id) {
	    retval.since_id = since_id;
	}

        // search term
        var arry = [];
        arry.push(term);
        arry.push(this.getWhereClause());
        retval.q = arry.join(" ");

        // "ors"
        retval.ors = this.getSourceTerm();

        // results per page
        retval.rpp = this.per_page;

        return retval;
    },

    extractLink : function(tweet) {
        var i, link;

        for (i = 0; i < this.providers.length; i++) {
            link = this.providers[i].extractLink(tweet);
            if (link) {
                return link;
            }
        }

        return undefined;
    },

    getSearchTerm : function() {
        return this.searchTerm;
    },

    getSourceTerm : function() {
        var searchTerms = [];

        $.each(this.providers, function(i, provider) {
            searchTerms.push(provider.searchTerm());
        });

        return searchTerms.join(" ");
    },

    getTwitterSearchUrl : function() {
        return "http://search.twitter.com/search.json?callback=?";
    },

    getWhereClause : function() {
        return "filter:links exclude:retweets";
    },

    search : function(term, onFirst, onEach, onLast, since_id) {
        var that = this;
        this.searchTerm = term;

	var safeSearch = function(safeQuery) {
	    return $.getJSON(that.getTwitterSearchUrl(),
			     safeQuery,
			     function(json) {
				 that.handleSearch(json, onFirst, onEach, onLast);
			     }
			     );
	};
	var aggressiveSearch = function(aggressiveQuery) {
	    return $.getJSON(that.getTwitterSearchUrl(),
			     aggressiveQuery,
			     function(json) {
				 if (json.error) {
				     console.log(json.error,
						 "trying safe search");
				     safeSearch(that.buildQuery(term));
				 }
				 else {
				     console.log("aggressive search succeeded");
				     that.handleSearch(json, onFirst, onEach, onLast);
				 }
			     }
			     );
	};

	return aggressiveSearch(this.buildQuery(term, since_id));
    },

    handleSearch : function(json, onFirst, onEach, onLast, mode) {
        var that = this;

        var firstTime = true;
        var lastTimer;          // undefined: never set; -1: don't set again

        // handler for each Oembed from a Twitter search result
        var handleOembed = function(i, result, oembed) {
            // fire only the first time
            if (firstTime) {
                onFirst(i, result, oembed);
                firstTime = false;
            }

            // fire on every time
            onEach(i, result, oembed);

            // fire only on the last time
            if (lastTimer !== -1) {
                if (lastTimer !== undefined) {
                    clearTimeout(lastTimer);
                }

                lastTimer = setTimeout(
                    function() {
                        timer = -1
                        onLast(i, result, oembed);
                    },
                    2000
                );
            }
        }

        // handler for each result in the twitter search
        var handleResult = function(i, result) {
            //cycle through providers and use the one that extract the
            //link successfully
            for (var p = 0; p < that.providers.length; p++) {
                var provider = that.providers[p];
                var link = provider.extractLink(result.text);
                if (link) {
                    // fire on interval to avoid hammering oembed
                    setTimeout(
                        function() {
                            provider.retrieveOembedUrl(
                                link,
                                function(oembed) {
                                    handleOembed(i, result, oembed);
                                });
                        },
                        i*that.pause
                    );

                    // break loop on finding correct provider
                    break;
                }
            }
        }

        // iterate over the Twitter search result
        $.each(json.results, handleResult);

        // search refresh and next_page
        var noOp = function() {};
        var searchPage = function(uri, mode) {
            return $.getJSON(
                "http://search.twitter.com/search.json" +
                    uri +
                    "&callback=?",
                {},
                function(json) {
                    that.handleSearch(json, noOp, onEach, noOp, mode);
                }
            );
        };
        var scheduleRefresh = function() {
            if (json.refresh_url) {
                setTimeout(
                    function() {
                        console.log("REFRESH", json.refresh_url);

                        searchPage(json.refresh_url, "refresh");
                    },
                    that.per_page * that.pause * 1.3
                );
            }
        };
        var scheduleNextPage = function() {
            if (json.next_page) {
                setTimeout(
                    function() {
                        console.log("NEXT_PAGE", json.next_page);

                        searchPage(json.next_page, "next_page");
                    },
                    that.per_page * that.pause * 3
                );
            }
        };

        if (mode === "refresh") {
            console.log("schedule refresh_url", json.refresh_url);
            scheduleRefresh();
        }
        else if (mode === "next_page") {
            console.log("schedule next_page", json.next_page);
            scheduleNextPage();
        }
        else {
            console.log("schedule both", json.refresh_url, json.next_page);
            scheduleRefresh();
            scheduleNextPage();
        }
    }
});

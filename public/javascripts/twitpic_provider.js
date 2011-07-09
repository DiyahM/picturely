/*
 * twitpic_provider.js
 *
 * Provider of Twitpic knowledge: name, extractLink, getOembed
 */

var TwitpicProvider = Class.$extend({

    /**
     * Given a tweet, extracts the full URL of an Twitpic link
     * embedded in that tweet.
     */
    extractLink : function(tweet) {
        var regexp = /http:\/\/(twitpic.com|t.co)\/[0-9a-zA-Z]+/i;
        var arry = regexp.exec(tweet);
        return arry ? arry[0] : undefined;
    },

    /**
     * Given an Twitpic link, retrieves the URL to the corresponding
     * media asset and invoke the callback function with it.
     */
    retrieveOembedUrl : function(link, onSuccess) {
        var that = this;
        var deferredOembed = $.Deferred();
        var regexp = /http:\/\/t.co\/[0-9a-zA-Z]+/i;

        // t.co
        if (regexp.exec(link)) {
            // unshorten t.co to either yFrog or TwitPic
            $.getJSON(
                "/realurl/resolve",
                {
                    format: "json",
                    url: link
                },
                function(unshortened) {
                    that.retrieveOembedUrl(unshortened.url,
                                           function(oembed) {
                                               onSuccess(oembed);
                                               deferredOembed.resolve();
                                           });
                }
            );
            return deferredOembed.promise();
        }
        // yfrog.com or twitpic.com
        else {
            return $.getJSON(
                "http://oohembed.com/oohembed?callback=?",
                { url: link },
                onSuccess
            );
        }
    },

    /*
     * Returns a search term that can be passed to Twitter search API
     * to pull out just the tweets with embedded twitpic.
     */
    searchTerm : function() {
        return "twitpic.com";
    }

});

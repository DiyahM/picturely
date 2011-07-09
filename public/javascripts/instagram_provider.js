/*
 * instagram_provider.js
 *
 * Provider of Instagram knowledge: name, extractLink, getOembed
 */

var InstagramProvider = Class.$extend({

    /**
     * Given a tweet, extracts the full URL of an Instagram link
     * embedded in that tweet.
     */
    extractLink : function(tweet) {
        var regexp = /http:\/\/instagr.am\/\S+/i;
        var arry = regexp.exec(tweet);
        return arry ? arry[0] : undefined;
    },

    /**
     * Given an Instagram link, retrieves the corresponding Oembed
     * JSON and invoke the callback function with it.
     */
    retrieveOembedUrl : function(link, onSuccess) {
        return $.getJSON(
            "http://api.instagram.com/oembed?callback=?",
            { url: link },
            onSuccess);
    },

    /*
     * Returns a search term that can be passed to Twitter search API
     * to pull out just the tweets with embedded Instagrams.
     */
    searchTerm : function() {
        return "instagr.am";
    }

});

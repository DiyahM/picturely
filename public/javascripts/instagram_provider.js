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
        var regexp = /http:\/\/(instagr.am|instagram.com|t.co)\/\w+\/?/i;
        var arry = regexp.exec(tweet);
        return arry ? arry[0] : undefined;
    },

    /**
     * Given an Yfrog link, retrieves the URL to the corresponding
     * media asset and invoke the callback function with it.
     */
    retrieveOembedUrl : function(link, onSuccess) {
        var that = this;
        var deferredOembed = $.Deferred();
        var regexp = /http:\/\/t.co\/\w+/i;

        // t.co
        if (regexp.exec(link)) {
            console.log("RESOLVE T.CO", link);

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
        }
        // yfrog.com or twitpic.com
        else {
            console.log("INSTAGRAM MEDIA", link);

	    var instaUrl = link + "media/";
	    onSuccess(instaUrl);
	    deferredOembed.resolve();
        }

       	return deferredOembed.promise();
    },

    /**
     * Given an Instagram link, retrieves the corresponding Oembed
     * JSON and invoke the callback function with it.
     */
    callInstagramOembed : function(link, onSuccess) {
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

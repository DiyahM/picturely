$(document).ready(function() {

	var populate_frame = function(frame, i, tweet) {
	    var div = $('<div class="thumbnail">'
			+ '<img width="100%" src="'
			+ tweet.url
			+ '" />'
			+ '</div>'
			);

	    // attach tweet object to div so that mouseOver or onClick
	    // can access the underlying data (yup, you're allowed to
	    // do this in JavaScript)
	    div.tweet = tweet;

	    // attach mouseOver or onClick handlers here or do it with
	    // jQuery
	    /* exercise left to the reader */

	    // finally, append div to panel
	    frame.append(div);
	};

	var tweets = [];			// array of tweets from search
	var term = $("#album_hashtag").val();
	var frame = $(".thumbnails_frame");

	var searcher = new Searcher();
	searcher.addProvider(new InstagramProvider());
        // searcher.addProvider(new TwitpicProvider());
        // searcher.addProvider(new YfrogProvider());

	var fnDoNothing = function(i, tweet, oembed) { /* ignore */ };
	searcher.search(term,
			fnDoNothing,
			function(i, tweet, oembed) {
			    if ("photo" === oembed.type) {
				// merge oembed fields into tweets
				// (yup, you can do that in JavaScript)
				tweet.url = oembed.url;
				tweet.provider_name = oembed.provider_name;
				tweet.type = oembed.type;

				populate_frame(frame, i, tweet);
			    } else {
				console.log("WRONG TYPE", i, oembed.type);
			    }
			},
			fnDoNothing
			);

    }
);

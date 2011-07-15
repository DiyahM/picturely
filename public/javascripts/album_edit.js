$(document).ready(function() {

	var populate_frame = function(frame, i, tweet) {
	    var d = $('<div class="thumbnail"><img width="100%" src="'
		      + tweet.url
		      + '" /></div>'
		      );
	    frame.append(d);
	};

	var tweets = [];			// array of tweets from search
	var term = $("#album_hashtag").val();
	var frame = $(".thumbnails_frame");

	var searcher = new Searcher();
	searcher.addProvider(new InstagramProvider());
        // searcher.addProvider(new TwitpicProvider());
        // searcher.addProvider(new YfrogProvider());

	searcher.search(term,
			function(i, tweet, oembed) { /* ignore */ },
			function(i, tweet, oembed) {
			    if ("photo" === oembed.type) {
				tweet.url = oembed.url;
				tweet.provider_name = oembed.provider_name;
				tweet.type = oembed.type;

				populate_frame(frame, i, tweet);
			    } else {
				console.log("WRONG TYPE", i, oembed.type);
			    }
			},
			function(i, tweet, oembed) { /* ignore */ }
			);

    }
);

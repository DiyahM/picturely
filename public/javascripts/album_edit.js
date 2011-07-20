$(document).ready(function() {
	// array of tweets from search
	var tweets = undefined;
	var tweets_cursor = 0;

	// generate thumb ID from "tweets_cursor"
	var genThumbId = function () {
	    return "thumb_" + (tweets_cursor++);
	}

	// 
	var append_to_frame = function(frame, tweet) {
	    var div = $('<div class="thumbnail"><img id="'
			+ genThumbId()
			+ '" width="100%" hspace="3" vspace="3" src="'
			+ tweet.url
			+ '" /></div>'
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
	    if (i==0) {
		$('#slide').html('<img src="'+tweet.url+'" width="80%" height="80%"/>');
	    }
	};

	var term = $("#album_hashtag").val();
	var frame = $(".thumbnails_frame");

	var searcher = new Searcher();
	searcher.addProvider(new InstagramProvider());
        // searcher.addProvider(new TwitpicProvider());
        // searcher.addProvider(new YfrogProvider());

	// determine current album ID
	var uri = new URI(window.location.href);
	var reg = new RegExp(/\/albums\/(\d+)\//);
	var album_id_matches = uri.path.match(reg);
	var album_id = album_id_matches[1];

	// searcher and callbacks to invoke on after getting persisted tweets
	var doNothing = function(i, tweet, oembed) { /* ignore */ };
	var album_add_tweet_path = "/albums/" + album_id + "/add_tweet.json";
	var addTweet = function(options) {
	    $.getJSON(album_add_tweet_path, options, doNothing);
	};
	var geoToString = function(geo) {
	    return geo ?
		("[" + geo.coordinates.toString(", ") + "]") :
		undefined;
	};
	var onTweet = function(i, tweet, oembed) {
	    if ("photo" === oembed.type
		|| "image" === oembed.type) {
		// merge oembed fields into tweets
		// (yup, you can do that in JavaScript)
		tweet.provider_name = oembed.provider_name;
		tweet.oembed_type = oembed.type;
		tweet.url = oembed.url;

		// default is_active to true
		tweet.is_active = true;

		// persist to back-end
		var options = {
		    "identifier":		tweet.id,
		    "text":			tweet.text,
		    "from_user_identifier":	tweet.from_user_id,
		    "created_at":		tweet.created_at,
		    "from_user":		tweet.from_user,
		    "profile_image_url":	tweet.profile_image_url,
		    "source":			tweet.source,
		    "geo":			geoToString(tweet.geo),
		    "provider_name":		tweet.provider_name,
		    "oembed_type":		tweet.oembed_type,
		    "url":			tweet.url
		};
		addTweet(options);

		// append to frame
		append_to_frame(frame, tweet);
	    } else {
		console.log("WRONG TYPE", i, oembed.type);
	    }
	};

	// fire off AJAX call to /albums/:ID/tweets.json
	if (album_id) {
	    var album_tweets_path = "/albums/" + album_id + "/tweets.json";

	    // retrieve persisted tweets from internal API
	    $.getJSON(album_tweets_path,
		      {},
		      function(arry) {
			  $.each(arry,
				 function(i, tweet) {
				     append_to_frame(frame, tweet);
				 }
				 );

			  console.log("persisted tweets: ", arry.length);

			  searcher.search(term,
					  doNothing,
					  onTweet,
					  doNothing
					  );
		      });
	}

    
    }

);


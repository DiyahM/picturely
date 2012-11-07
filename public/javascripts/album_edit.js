$(document).ready(function() {
	// determine current album ID
	var uri = new URI(window.location.href);
	//var reg = new RegExp(/\/albums\/(\d+)\//);
	//var album_id_matches = uri.path.match(reg);
	//var album_id = album_id_matches[1];
	var album_id_matches = String(uri).split("/");
	var album_id = album_id_matches[4];

	// hash of tweet IDs to tweets to avoid double adding a tweet to frame
	var tweets = {};
	var tweets_cursor = 0;

	// generate thumb ID from "tweets_cursor"
	var genThumbId = function () {
	    return "thumb_" + (tweets_cursor++);
	}

	// show tweet details in a panel
	var showTweetDetails = function(tweet) {
	    $("#tweet_url").attr("src", tweet.url);

	    $("#tweet_from_user").
		text(tweet.from_user).
		attr("href", "http://twitter.com/" + tweet.from_user);

	    $("#tweet_text").text(tweet.text);
	};

	// click handler to show details of a tweet attached to a DOM element
	var fnShowDetails = function(tweet) {
	    return function(evt) {
		showTweetDetails(tweet);
	    };
	};

	// click handler for check box; binds tweet in closure and
	// calls API to set is_active flag accordingly
	var setActiveFlagPath = "/albums/" + album_id + "/set_active.json";
	var fnClickCheckbox = function(tweet) {
	    return function(evt) {
		// console.log($(evt.currentTarget).is(":checked"), tweet);
		var checkbox = $(evt.currentTarget);
		var options = {
		    "identifier":	tweet.id,
		    "is_active":	checkbox.is(":checked")
		};
		$.getJSON(setActiveFlagPath,
			  options,
			  function(json) {});
	    }
	};

	// Tries to add to frame (if it isn't there already). If
	// added; returns true; otherwise, returns false;
	var add_to_frame = function(frame, tweet) {
	    // check whether tweet is already in frame
	    var already_there = tweets[tweet.id];
	    if (already_there) {
		return false;
	    }
	    else {
		tweets[tweet.id] = tweet;
	    }

	    // create thumbnail DIV on the fly to hold both image and checkbox
	    var div = $('<div class="thumbnail"><img id="'
			+ genThumbId()
			+ '" width="100%" hspace="3" vspace="3" src="'
			+ tweet.url
			+ '" /></div>'
			);

	    // attach tweet object to click function so that onClick
	    // can access the underlying data
	    div.hover(fnShowDetails(tweet));

	    // finally, prepend div to panel
	    frame.prepend(div);

	    // checkbox
	    var checkbox = $('<input type="checkbox" class="checkbox" '
			     + (tweet.is_active ? 'checked="true"' : '')
			     + '/>');
	    checkbox.click(fnClickCheckbox(tweet));
	    div.append(checkbox);

	    // display first slide detail (tweets_cursor has already been ++)
	    if (1 == tweets_cursor) {
		showTweetDetails(tweet);
	    }

	    // return true to indicate the tweet was added
	    return true;
	};

	// variables needed for the search; note that JavaScript vars
	// are not defined at point of use (but rather, all at the top
	// of the function) - we're listing them like this just for
	// logical clarity
	var term = $("#album_hashtag").val();
	var frame = $(".thumbnails_frame");

	var searcher = new Searcher();
	searcher.addProvider(new InstagramProvider());
	searcher.addProvider(new InstagramComProvider());
    searcher.addProvider(new TwitpicProvider());
    searcher.addProvider(new YfrogProvider());

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

		// try to add to frame
		if (add_to_frame(frame, tweet)) {

		    // persist to back-end
		    var options = {
			"identifier":		tweet.id,
			"text":			tweet.text,
			"from_user_identifier":	tweet.from_user_id,
			"created_at":		tweet.created_at,
			"from_user":		tweet.from_user,
			"profile_image_url":	tweet.profile_image_url,
			"source":		tweet.source,
			"geo":			geoToString(tweet.geo),
			"provider_name":	tweet.provider_name,
			"oembed_type":		tweet.oembed_type,
			"url":			tweet.url
		    };
		    addTweet(options);
		}
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
			  // array of tweets is in oldest to youngest order
			  $.each(arry,
				 function(i, tweet) {
				     add_to_frame(frame, tweet);
				 }
				 );

			  console.log("persisted tweets: ", arry.length);

			  // get youngest tweet ID
			  var youngest = arry[arry.length - 1];
			  var since_id = youngest ? youngest.id : undefined;

			  console.log("since_id", since_id);

			  searcher.search(term,
					  doNothing,
					  onTweet,
					  doNothing,
					  since_id
					  );
			  /*
			  */
		      });
	}

    
    }

);


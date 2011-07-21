$(function() {
	
	var slider = new ImaikuShow();
$(document).ready(function() {
	// determine current album ID
	/*var uri = new URI(window.location.href);
	var reg = new RegExp(/\/albums\/(\d+)\//);
	var album_id_matches = uri.path.match(reg);
	var album_id = album_id_matches[1];*/

	// slider abstraction
    

/*var album_tweets_path = "/albums/" + album_id + "/tweets.json";*/
	   $("#header").hide();
	  	

	    // retrieve persisted tweets from internal API
	    $.getJSON("/albums/1/tweets.json",
		      function(arry) {
			  $.each(arry,
				 function(key) {
				     slider.addItem(arry[key]);
				 }
				 );

			  console.log("persisted tweets: ", arry.length);

			  	// show slides a second later
              setTimeout(
                  function() {
                      //logDebug("start", i);
                      startSlideShow();
                  },
                  1);
			  /*
			  */
			});
		    
	
});

function startSlideShow() {
    var tweet = slider.currItem();
    showSlide(tweet);

    slider.setRepeatTimer(
        function(tweet) {
            showSlide(tweet);
        },
        4000
    );

    // add corners to caption panel
    //$("#caption").corner().dropShadow();
}

function showSlide(tweet) {
    var slide = $("#slide");
    var src = tweet.url;

    slide.attr("src", src);
    //resizeImg(slide.first(), $("#top").first());

    //$("#term").text(term);
    $("#handle").text("@" + tweet.from_user);
    $("#tweet").text(tweet.text);
}
});
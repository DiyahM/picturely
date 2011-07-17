$(function() {
    

	$(document).ready(function(){
		$.getJSON("http://search.twitter.com/search.json?callback=?&q=breakfast%2C%20instagr.am&nots=RT&filter=links&rpp=10", function(json_results){
			console.log(json_results);
			var ip = new InstagramProvider();
			
			$.each(json_results.results, function(key){
				var link = ip.extractLink(json_results.results[key].text);
				var src=link+"media/";
				if (!link){
					src="images/picturely.png";
					link="";
				}
				
				
				
			
				/*html='<a href="'+link+'" target="_blank""><img src="'+src+'" alt="picturely beta stupid pictures wont load" width=230; height=230; hspace=4; vspace=4;></a>';
				var old = $('#picture-box').html();
				$('#picture-box').html(old + html);*/
				
				html='<img src="'+src+'" alt="picturely beta stupid pictures wont load" width=230; height=230; hspace=4; vspace=4;>';
				var old = $('#picture-box').html();
				$('#picture-box').html(old + html);
				
				
				
			});
		});
		
	});
	
	
	
	
	
	//$("#search_dialog").corner().dropShadow();

    setInterval(
        function() {
            mpmetrics.track("minutes");
        },
        60000
    );

    function hideMainSearch() {
        //$("#search_dialog").removeShadow().hide();
		$("#header").hide();
		$("#container").hide();
		$("body").css("background-color","black");
		$("#mini-form").show();
		//$("#caption").show();	
       
    }

    function showMainSearch() {
       // $("#search_dialog").dropShadow().show();
        $("#caption").hide();
		$("#mini-form").hide();
		$("#header").show();
		$("body").css("background-color","white");
		
    }

    // check for sponsors
    var sponsor = $.getUrlVar('sponsor');
    if (sponsor == 'redbull') {
        $("body").css(
            "background-image",
            "url(http://www.logodesignworks.com/blog/images/Red-Bull-logo-design.jpg)"
        );

        mpmetrics.track('sponsor', {'org': 'redbull'});
    }
    else if (sponsor == 'sllconf') {
        $("body").css(
            "background-image",
            "url(images/sllconf.jpg)"
        );

        mpmetrics.track('sponsor', {'org': 'sllconf'});
    }
    else if (sponsor == 'atlassian') {
        $("body").css(
            "background-image",
            "url(images/atlassian.jpg)"
        );

        mpmetrics.track('sponsor', {'org': 'atlassian'});
    }

    // Resizes an image within a div while maintaining aspect
    // ratio and not cropping. Pass "img" and "div" as jQuery
    // objects; i.e., img = $("#someImage"). Modified for jQuery
    // from http://bit.ly/kVCEBc
    //
/*
    var resizeImg = function(img, div) {
        setTimeout(
            function() {
                resizeImgImmediate(img, div);
            },
            0
        );
    }
*/
    var switchTo5x=true;

	var resizeImg = function(img, div) {
        
		$("img#slide").width(width);
		$("img#slide").height(height);
		
		/*img.width("auto");
		img.height("auto");

	var div_height = div.height()
	var div_width  = div.width()
	var image_width   = img.width()
	var image_height  = img.height()

        console.log([image_width, image_height], [div_width, div_height]);

        if (image_height > div_height || image_width > div_width) {
	    var height_ratio  = image_height / div_height
	    var width_ratio   = image_width / div_width

	    if (height_ratio > width_ratio)
	    {
		img.width(image_width/height_ratio);
		img.height(div_height);
	    }
	    else
	    {
		img.width(div_width);
		img.height(image_height/width_ratio);
	    }

            console.log("SCALED", img.width(), img.height(), img.attr("src"));
        }
        else {
            img.width("auto");
	    img.height("auto");

            console.log(img.width(), img.height(), img.attr("src"));
        }*/
		
    };

    $(window).resize(function () {
        var t = $("#top").first();
        var p = $("#slide").first();
        resizeImg(p, t);
    });

    // slider abstraction
    var slider = new ImaikuSlider();

	//check for embed
	var embed = $.getUrlVar('embed');
	if (embed == 'true')
	{
		$("img#slide").css({"position":"absolute","top":"0","left":"0"});
		//$("#caption").css({"position":"absolute","bottom":"0","left":"0","width":"100%"});
		$("#mini-form").css({"bottom":"0","right":"4px","margin-bottom":"-4px","padding":"0"});
		$("#mini_status").hide();
		$("#mini-form").show();
		
		
		$("#caption").hide();
		
		

	}else{
		 //$("#caption").show();
	     //$("#mini-form").show();
		 $("#mini-form").css({"top":"0"});
		 var addhtml = 	"</br>Hint: Try full screen mode in Firefox or Chrome :)";
		 $("#mini-form").append(addhtml);
	}
	
	//check for size	
	var height = $.getUrlVar('height');
	var width = $.getUrlVar('width');
	
	if (height == undefined)
		height = 600;
	if (width == undefined)
		width = 800;
		
	
	

    // check "q" parameter for search parameter
    var param = $.getUrlVar('q');
    if (param == undefined) {
        showMainSearch();
        mpmetrics.track("landing");
    }
    else {
		
        var searcher = new Searcher();
        searcher.addProvider(new InstagramProvider());
        searcher.addProvider(new TwitpicProvider());
        searcher.addProvider(new YfrogProvider());

        var term = decodeURIComponent(param).replace(/\+/g, " ");
        searcher.search(
            term,
            function(i, tweet, oembed) {      // first successful oembed
                // hide search box if there's at least 1 search result
                hideMainSearch();

                // show slides a second later
                setTimeout(
                    function() {
                        logDebug("start", i);
                        startSlideShow();
                    },
                    1);
            },
            function(i, tweet, oembed) {      // every successful oembed
                logDebug(i, oembed.url);
                tweet.oembed = oembed;
                slider.addItem(tweet);
            },
            function(i, tweet, oembed) {      // last successful oembed
                logDebug("last", i);
            }
        );

        mpmetrics.track('search', {'term': term});
    }

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
        var src = tweet.oembed.url;

        slide.attr("src", src);
        resizeImg(slide.first(), $("#top").first());

        $("#term").text(term);
        $("#handle").text("@" + tweet.from_user);
        $("#tweet").text(tweet.text);
    }

    function buildHref(body, url) {
        return "<a href='" + url + "'>" + body + "</a>";
    }

    function buildQuery(term) {
        return term + ' filter:links source:instagram exclude:retweets';
    }

    function buildTwitterHref(handle) {
        // return "<a href='" + buildTwitterUrl(handle) + "'>" + handle + "</a>";
        return buildHref(handle, buildTwitterUrl(handle));
    }

    function buildTwitterUrl(handle) {
        return "http://twitter.com/" + handle;
    }

    function instagramEmbedApi(url) {
        return "http://api.instagram.com/oembed?url="+escape(url);
    }

    function extractInstaUrl(tweet) {
        var regexp = /http:\/\/instagr.am\/\S+/i;
        return regexp.exec(tweet);
    }

    function logDebug() {
        if (false) {
            console.log(arguments);
        }
    }
});

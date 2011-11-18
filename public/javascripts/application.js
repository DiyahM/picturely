//javascript file for testing



$(function() {
	
	
	
	$(document).ready(function(){
		search();
		
	});
	
	var search = function(){
		$.getJSON("http://api.twitter.com/i/search/image_facets.json?jcallback?&q=beer&count=100&score=true&offset=0&mode=photos&query=beer&include_entities=true", function(json_results){
			$.each(json_results.url, function(key){
				$('#picture-box').append(json_results.url + "</br>");
			});
		});
	};
})


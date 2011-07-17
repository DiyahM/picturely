// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
	
		$.getJSON("http://search.twitter.com/search.json?callback=?&q=time+square%2C%20instagr.am&nots=RT&filter=links&rpp=10", function(json_results){
			console.log(json_results);
			var ip = new InstagramProvider();
			
			$.each(json_results.results, function(key){
				var link = ip.extractLink(json_results.results[key].text);
				var src=link+"media/";
				if (!link){
					src="images/picturely.png";
					link="";
				}
				
				
				
			
				html='<a href="'+link+'" target="_blank""><img src="'+src+'" alt="picturely beta stupid pictures wont load" width=230; height=230; hspace=4; vspace=4;></a>';
				$('#test').append(html);
				
				
			});
		});
		

});

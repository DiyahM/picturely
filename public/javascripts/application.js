// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
	$.ajax({
		url: "http://search.twitter.com/search.json?q=san%20francisco&filter=links",
		dataType: 'jsonp',
		success: function(json_results){
			console.log(json_results);
			$('#tweets').append('<ul data-role="listview"></ul>');
			listItems = $('#tweets').find('ul');
			$.each(json_results.results, function(key){
				html = '<img src="'+json_results.results[key].profile_image_url+'"/>';
				html += '<h3><a href="#">'+json_results.results[key].text+'</a></h3>';
				html += '<p>From: '+json_results.results[key].from_user+' Created: '+json_results.results[key].created_at+'</p>';
				listItems.append('<li>'+html+'</li>');
			});
			$('#tweets ul').listview();
		}
	});
})

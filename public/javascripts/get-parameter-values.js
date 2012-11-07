// Extract URL parameter values
//
// http://jquery-howto.blogspot.com/2009/09/get-url-parameters-values-with-jquery.html
//
// If you include this code in your javascript file, you can get
// URL parameter values in the following way:
//
// // Get object of URL parameters
// var allVars = $.getUrlVars();
//
// Getting URL var by its nam
// var byName = $.getUrlVar('name');
//

$.extend({
    getUrlVars: function(){
	var vars = [], hash;
	var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
	for(var i = 0; i < hashes.length; i++)
	{
	    hash = hashes[i].split('=');
	    vars.push(hash[0]);
	    vars[hash[0]] = hash[1];
	}
	return vars;
    },
    getUrlVar: function(name){
	return $.getUrlVars()[name];
    }
});


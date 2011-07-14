// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
$('.popup-win').openDOMWindow({ 

positionType:'centered', 
 
eventType:'click',
height:'300',
width:'420',
positionTop:'200', 

windowSource:'iframe', 

});
});

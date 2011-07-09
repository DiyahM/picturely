// input-fadeout.js
//
// Fades out the value of an input box when it gets focus. See
// http://buildinternet.com/2009/01/changing-form-input-styles-on-focus-with-jquery/
//

$(document).ready(function() {
    $('#status').addClass("idleField");
    $('#status').focus(function() {
        $(this).removeClass("idleField").addClass("focusField");
        if (this.value == this.defaultValue) {
            this.value = '';
        }
        if (this.value != this.defaultValue){
            this.select();
        }
    });


});

/*
 * Imaiku Slider
 *
 * Slideshow abstraction for Imaiku - allows dynamic addition of
 * slides to queue.
 *
 */

function ImaikuSlider() {

    this.queue = [];

    this.cursor = 0;

    this.timer = -1;
	show=false;

}
var show;
//constructor for use for show page
function ImaikuSlider(show) {

    this.queue = [];

    this.cursor = 0;

    this.timer = -1;
	show = true;

}

ImaikuSlider.prototype.addItem = function(item) {
    return this.queue.push(item);
}

ImaikuSlider.prototype.clearTimer = function() {
    if (this.timer !== -1) {
	clearTimeout(this.timer);
	this.timer = -1;
    }
}

ImaikuSlider.prototype.currItem = function() {
    var curr = this.queue[this.cursor];

    // prefetch the next item in a later event loop
    var i = this.getNextIndex();
    if (i !== this.cursor) {
        setTimeout(
            function(that) {
                return function() {
                    // TOFIX: hacky as we assume a non-display image
                    // with ID "slide_prefetch" to already exist
                    var prefetch = $("#slide_prefetch");
					if (!show)
                    	prefetch.attr("src", that.queue[i].oembed.url);
					else
						prefetch.attr("src",that.queue[i].url)
                }
            }(this),
            20
        );
    }

    return curr;
}

ImaikuSlider.prototype.getNextIndex = function() {
    return (this.cursor < this.length() - 1) ? (this.cursor + 1) : 0;
}

ImaikuSlider.prototype.length = function() {
    return this.queue.length;
}

ImaikuSlider.prototype.next = function() {
    this.cursor = this.getNextIndex();
    return this.currItem();
}

ImaikuSlider.prototype.previous = function() {
    this.cursor = (this.cursor == 0 && this.length() > 0) ? (this.length() - 1) : 0;
    return this.queue[this.cursor];
}

ImaikuSlider.prototype.setRepeatTimer = function(func_item, milliseconds) {
    var that = this;

    this.clearTimer();
    this.timer = setInterval(
	function() {
	    return func_item(that.next());
	},
	milliseconds
    );
}



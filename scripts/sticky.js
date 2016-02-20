/* Refactored by David Walsh
 * (https://davidwalsh.name/javascript-debounce-function) */
function debounce(callback, wait) {
	var time;
	return function() {
		clearTimeout(time);
		time = setTimeout(function() {
			time = null;
			callback.call();
		}, wait);
	}
}

window.onload = function(){
	/* flag to decrease redraw events */
	var sticky = false;
	var nav    = document.getElementById("menu");
	var fill   = document.getElementById("fill");
	var header = document.getElementsByTagName("header")[0];

	var nav_offset    = nav.offsetTop;
	var header_offset = header.offsetTop;

	var offs = window.pageYOffset;
	
	if(!sticky && offs > nav_offset) {
		sticky = true;
		fill.style.height  = 40 + "px";
		nav.style.position = "fixed";
		nav.style.top      = 0 + "px";
		nav.style.width    = header.offsetWidth + "px";
	}

	scrollHandler = debounce(function() {
		offs = window.pageYOffset;

		if(!sticky && offs > nav_offset) {
			sticky = true;
			fill.style.height  = 40 + "px";
			nav.style.position  = "fixed";
			nav.style.top       = 0 + "px";
			nav.style.width     = header.offsetWidth + "px";
			nav.style.boxShadow = "0 8px 4px -4px #4D4D4D";
		}

		if(sticky && offs < nav_offset) {
			sticky = false;
			nav.style.position = "relative";
			nav.style.boxShadow = "none";
			fill.style.height  = 0 + "px";
		}
	}, 5);

	window.onscroll = scrollHandler;

}

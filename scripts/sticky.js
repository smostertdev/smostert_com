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
	var header = document.getElementsByTagName("header")[0];

	var nav_offset    = nav.offsetTop;
	var header_offset = header.offsetTop;

	var offs = window.pageYOffset;
	
	if(!sticky && offs > nav_offset) {
		sticky = true;
		nav.style.position = "fixed";
		nav.style.top      = 0 + "px";
		nav.style.width    = header.offsetWidth + "px";
	}

	scrollHandler = debounce(function() {
		offs = window.pageYOffset;

		if(!sticky && offs > nav_offset) {
			sticky = true;
			nav.style.position = "fixed";
			nav.style.top      = 0 + "px";
			nav.style.width    = header.offsetWidth + "px";
			
		}

		if(sticky && offs < nav_offset) {
			sticky = false;
			nav.style.position = "relative";
		}
	}, 5);

	window.onscroll = scrollHandler;

}

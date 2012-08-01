function scroll_to_top() {
	$('body').animate({ scrollTop: 0 }, 500);
}

function scroll_to(element, padding) {
	$('html, body').animate({
		scrollTop: $("#"+element).offset().top - padding
	}, 500);
	return false
}
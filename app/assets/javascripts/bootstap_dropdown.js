$(document).ready(function(){
	
	$('.dropdown-menu li a').click(function(){
		
		var link_text = $(this).html() + "<b class='caret'></b>"
		li_id = $(this).closest('ul').closest('li').attr('id')
		var dropdown_select = $("#"+li_id+" a[data-toggle='dropdown']")
		
		dropdown_select.html(link_text)
	})
	
})
$(document).ready(function(){
	$('#url').keyup(function(){
		var url = $(this).val()
		$('#show_match_details').attr('href', '/?url='+url)
	})
})
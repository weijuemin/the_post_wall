$(function(){
	var login = $('#loginForm');
	var register = $('#registerForm');
	$('div.btn-link .lrControl:first-child').hide();
	register.hide();
	$('.initial').hide();
	$('.lrControl').on('click', function(){
		$('.lrControl').add(login).add(register).toggle();
	})
	$('input').on('click',function(){
		$(this).parent().next('.flash').hide();
	})
})
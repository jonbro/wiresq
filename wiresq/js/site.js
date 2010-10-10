$(document).ready(function(){
	Cufon.replace('.help_block h3, h2');
	Cufon.replace('#logo, #menu li a', {hover:true});
	$('#he_logo').hover(function(){
		$(this).animate({backgroundColor: '#5e82a5'}, 200);
	},function(){
		$(this).animate({backgroundColor: '#0080ff'}, 200);
	})
});
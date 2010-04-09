$(function () {  
    $('#pagination > li > a').live("click", function () {  
  		$('.pagination').html('Loading...');
		$.get(this.href, null, null, 'script');  
        return false;  
    });  
});
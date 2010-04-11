$(function () {  
    $('#timeline-control > ul > li > a').live("click", function () {  
  		$('#timeline-control').html('Loading...');
		$.get(this.href, null, null, 'script');
        return false;  
    });  
});
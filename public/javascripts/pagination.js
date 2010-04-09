$(function () {  
    $('#pagination > li > a').live("click", function () {  
  		$.get(this.href, null, null, 'script');  
        return false;  
    });  
});
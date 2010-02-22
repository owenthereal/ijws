/*
 * charCounter - counts down the number of characters in a textarea
 * By Andrea Pinkus (http://www.dowhatyouwish.com)
 * Copyright (c) 2009 Andrea Pinkus
 * Licensed under the MIT License: http://www.opensource.org/licenses/mit-license.php
*/

(function($) {
	$.fn.charCounter = function(options){
		var defaults = {
			counterId:"counter",
			msgText:"%n",
			errorClass:"error",
			warningClass:"warning",
			submitButtonId:"submitButton"
		};  
		var options = $.extend(defaults, options);
		
		return this.each(function(){
			var maxChars = $("#" + options.counterId).text().replace(/[^0-9]/g, "");
			var warningChars = maxChars - maxChars * 0.2
			var errorChars = maxChars - maxChars * 0.1
			
			$(this).bind("keypress keyup keydown change click blur", function(){
				var charCount = $(this).val().length;
				$("#" + options.counterId)
					.text(options.msgText.replace("%n", maxChars - charCount))
					.toggleClass(options.errorClass, charCount >= errorChars)
					.toggleClass(options.warningClass, charCount >= warningChars && charCount < errorChars);
				
				if(charCount == 0 || charCount > maxChars) {
					$("#" + options.submitButtonId).attr("disabled", "disabled").addClass("inact");
				}else {
					$("#" + options.submitButtonId).removeAttr("disabled").removeClass("inact");
				}
					
			}).change();
		});
	};
})(jQuery);
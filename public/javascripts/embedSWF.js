function embedSWF(container_id, text2speech_url, autostart) {
	var flashvars  = {
		"file": text2speech_url,
		"autostart": autostart,
		"provider": "sound",
		"bufferlength": "0",
	};
	var params     = {
		"allowscriptaccess": "always" 
	};

	var attributes = {
	};

	swfobject.embedSWF("/flash/player.swf", 
	container_id, 
	"300", 
	"24", 
	"9.0.0",
	"expressInstall.swf", 
	flashvars, 
	params, 
	attributes
	);
}


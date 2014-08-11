var ready;
ready = function() {
	//var dj=true;
	alert(gon.dj);
	if (gon.dj==false){
	//$("#sm2_player").click(function() { alert('test'); });
	$("#sm2_player").click(function() { return false; });
	//$("#sm2_player").click(function(e) { e.stopPropagation(); });
	};
};
$(document).ready(ready);
$(document).on('page:load', ready);
var ready;
ready = function() {
	var pagePlayer = null;
	var listener;
	var channel;
	var currentPosition;
	var dj;

	channel = $.ajax({
	  type: "GET",
	  cache: false,
	  async: false,
	  //url: "/channels/"+ $(this).attr('value'),
	  url: window.location.pathname+"/sendChannelToDj",
	  dataType: "JSON",
	  //data: { currentPosition: currentPosition },
	  success: function(data) {
	    //console.log(data);
	    //currentPosition=data;
	    //console.log(currentPosition);
	  }
	});

	console.log(channel.responseText);
	channel=JSON.parse(channel.responseText);
	console.log(channel.currentPosition);
	currentPosition=channel.currentPosition

	listener = $.ajax({
	  type: "GET",
	  cache: false,
	  async: false,
	  //url: "/channels/"+ $(this).attr('value'),
	  url: window.location.pathname+"/sendListenerToDj",
	  dataType: "JSON",
	  //data: { currentPosition: currentPosition },
	  success: function(data) {
	    //console.log(data);
	    //currentPosition=data;
	    //console.log(currentPosition);
	  }
	});

	console.log(listener.responseText);
	listener=JSON.parse(listener.responseText);
	console.log(listener.dj);
	dj=listener.dj;

	soundManager.useFlashBlock = true;
	soundManager.onready(function() {
  		pagePlayer = new PagePlayer(dj,currentPosition);
  		pagePlayer.init(typeof PP_CONFIG !== 'undefined' ? PP_CONFIG : null);
	});
	if (dj==false){
	//$("#sm2_player").click(function() { alert('test'); });
	$("#sm2_player").click(function() { return false; });
	//$("#sm2_player").click(function(e) { e.stopPropagation(); });
	};
};
$(document).ready(ready);
$(document).on('page:load', ready);
var ready;
ready = function() {
	var pagePlayer = null;
	var listener;
	var channel;
	var currentPosition;
	var dj;

	if ($("#sm2_player").length !== 0){

		var song = {
			name: 'Start taking advantage of WebSockets',
			completed: false
		};
    
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

		//var dispatcher = new WebSocketRails(window.location.host +'/websocket');
		
		//dispatcher.trigger('new_message', currentPosition);

		//var success = function(song) { console.log("Created: " + song.name); };

		//var failure = function(song) {
  		//		console.log("Failed to create Song: " + song.name)
		//};

		//dispatcher.trigger('songs.create', song,success(song),failure(song));



		//dispatcher.bind('song.new_message', function(song) {
  		//	console.log('successfully created ' + currentPosition);
		//});

		if (dj==false){
		//$("#sm2_player").click(function() { alert('test'); });
		$("#sm2_player").click(function() { return false; });
		//$("#sm2_player").click(function(e) { e.stopPropagation(); });
		};
	};
};
$(document).ready(ready);
$(document).on('page:load', ready);
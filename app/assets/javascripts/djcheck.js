var ready;
ready = function() {
	var pagePlayer = null;
	var listener;
	var channel;
	var currentPosition;
	var dj;
	var mp3url;
	var $list = $(".sm2_player");
	var dispatcher = new WebSocketRails(window.location.host +'/websocket');

	dispatcher.bind('add_song',function(mp3) {
			//$("#mp3url").val('');
			console.log((mp3["track"]).permalink_url);
			//scobject=JSON.parse(mp3["track"]);
			//console.log(scobject.permalink_url);
			var $li = $("<li>").html('<a href="'+mp3["track"]+'"></a>');
			$("#playlist").append($li);
			//console.log($("#playlist").append($li));
		});

	if ($("#sm2_player").length !== 0){

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
	  		pagePlayer = new PagePlayer(dj,currentPosition,dispatcher);
	  		pagePlayer.init(typeof PP_CONFIG !== 'undefined' ? PP_CONFIG : null);
		});


		$("#add2playlist").click(function() {
			mp3url = $("#mp3url").val();
			console.log(mp3url);
			dispatcher.trigger('add_song',{text: mp3url});
			// $("#mp3url").val('');
			// var $li = $("<li>").html('<a href="'+mp3url+'"></a>');
			// $("#playlist").append($li);
			// console.log($("#playlist").append($li));
			return false;
		});
		// ("#mp3url").keypress(function(e) {
		// 		if(e.keyCode == 13) {
		// 			$("#add2playlist").click()
		// 		}
		// });
		
		if (dj==false){
		//$("#sm2_player").click(function() { alert('test'); });
			$("#sm2_player").click(function() { return false; });
		//$("#sm2_player").click(function(e) { e.stopPropagation(); });
		};
	};
};
$(document).ready(ready);
$(document).on('page:load', ready);
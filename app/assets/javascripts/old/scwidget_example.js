$(function() {
  initPage();
});
$(window).bind('page:change', function() {
  initPage();
});

function initPage(){

      var consoleBox = document.querySelector('.console');

      function clearConsole() {
        consoleBox.value = '';
      }

      function updateConsole(value) {
        consoleBox.value = value +"\n" + consoleBox.value;
      }

      consoleBox.value = "Loading...";

      var iframe = document.querySelector('iframe');
      var widget = SC.Widget(iframe);

      var eventKey, eventName;
      var url= window.location.pathname+'/eventtracker';
      var forRails;
      for (eventKey in SC.Widget.Events) {
        (function(eventName, eventKey) {
          eventName = SC.Widget.Events[eventKey];
          widget.bind(eventName, function(eventData) {
            updateConsole("SC.Widget.Events." + eventKey +  " " + JSON.stringify(eventData || {}));
            forRails = eventData;

            $.ajax({
              type: "POST",
              url: url,
              data: forRails,
              dataType: "json"
            });
            $.ajax({
              type: "POST",
              url: url,
              data: {"state": eventKey},
              dataType: "json"
            });
          });
        }(eventName, eventKey))
      }

};
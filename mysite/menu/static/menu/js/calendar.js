$(document).ready(function() {
    $('#calendar').fullCalendar({
        events:window.events,
		header: {
		  right:'month basicWeek today prev,next'
		},
		defaultView: 'basicWeek',
		eventClick: function(calEvent, jsEvent, view) {
		  window.location =  calEvent.updateUrl;
		}
    })

});
$(document).ready(function() {
    $('#actions-modal').modal({
	  show: false
	});
    $('#calendar').fullCalendar({
        events:window.events,
		header: {
		  right:'month basicWeek today prev,next'
		},
		defaultView: 'basicWeek',
		eventClick: function(calEvent, jsEvent, view) {
		  $('#edit-anchor').attr("href", calEvent.updateUrl);
		  $('#delete-anchor').attr("href", calEvent.deleteUrl);
		  $('#actions-modal').modal('show');
		}
    })

});
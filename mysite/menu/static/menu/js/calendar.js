$(document).ready(function() {
    $('#actions-modal').modal({
	  show: false
	});
	 w = $('#calendar').css('width');
		var beforePrint = function() {
			// prepare calendar for printing
			$('#calendar').css('width', '10in');
			$('#calendar').fullCalendar('render');
		};
		var afterPrint = function() {
			$('#calendar').css('width', w);
			$('#calendar').fullCalendar('render');
		};
		if (window.matchMedia) {
			var mediaQueryList = window.matchMedia('print');
			mediaQueryList.addListener(function(mql) {
				if (mql.matches) {
					beforePrint();
				} else {
					afterPrint();
				}
			});
		}
		window.onbeforeprint = beforePrint;
		window.onafterprint = afterPrint;
    $('#calendar').fullCalendar({
	    firstDay: 3,
		timezone:false,
        events:'/menu/calendar/',
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
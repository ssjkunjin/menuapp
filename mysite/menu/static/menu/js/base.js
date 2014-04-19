  var pathname = window.location.pathname;
  $('.nav li a').each(function(index) {
    var href = $(this).attr("href");
	if (pathname != null && pathname.indexOf(href) > -1) {
	  console.log("matched");
	  $(this).parent().addClass("active");
	  return;
	}
  });

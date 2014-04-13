$(document).ready(function() {
  function delete_row() {
    var total_forms = $( "#id_form-TOTAL_FORMS" );
	var no_forms = parseInt(total_forms.val());
	total_forms.val(--no_forms);
    $(this).parents('tr').remove();
	$( "#recipe_table tbody tr" ).each(function(index) {
	   $(this).find("input","select").each(function() {
	     this.name = this.name.replace(/\d+/,index);
		 this.id = this.id.replace(/\d+/,index);
	   });
	});
	
  }
  
  $( "#add_recipe_row" ).click(function() {
    var total_forms = $( "#id_form-TOTAL_FORMS" );
	var no_forms = parseInt(total_forms.val());
	var max_forms = parseInt($( "#id_form-MAX_NUM_FORMS" ).val());
	if (no_forms < max_forms) {
	  var new_recipe_form = $( "#recipe_table tfoot .hidden" ).html().replace(/\__prefix__/g, no_forms);
	  $( "#recipe_table tbody" ).append( "<tr></tr>" );
	  $( "#recipe_table tbody tr:last" ).append(new_recipe_form);
	  $( "#recipe_table tbody tr:last a.delete_row" ).click(delete_row);
	  total_forms.val(++no_forms);
	}
    
  });
  
  $('#id_date').datepicker();
});

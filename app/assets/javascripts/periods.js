 // Place all the behaviors and hooks related to the matching controller here.
 // All this logic will automatically be available in application.js.

app.periods = {
  tableRichest: function () {
    $('.period-table').find('.period-table-info-richest').each(function (index, element) {

      if ($(element).text() === 'true') {
        $(element).html('<i class="fa fa-money fa-2x"></i>');
      } else {
        $(element).text('');
      }
    });

  }


}

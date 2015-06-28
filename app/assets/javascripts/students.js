 // Place all the behaviors and hooks related to the matching controller here.
 // All this logic will automatically be available in application.js.

app.students = {
  tableRichest: function () {
    $('.student-table').find('.student-table-info-richest').each(function (index, element) {

      if ($(element).text() === 'true') {
        $(element).html('<i class="fa fa-money fa-2x"></i>');
      } else {
        $(element).text('');
      }
    });

  },

  individualRichest: function () {
    var str = $('.student-show-richest-text').text();

    if (str === 'true') {
      $('.student-show-richest-text').text('Yes');
    } else {
      $('.student-show-richest-text').text('No');
    }

  },

  tableBehavior: function () {
    $('.student-table').find('.student-table-info-behavior').each(function (index, element) {

      if ($(element).text() === 'true') {
        $(element).html('<i class="fa fa-star-o fa-2x"></i>');
      } else {
        $(element).text('');
      }
    });

  },


}

 // Place all the behaviors and hooks related to the matching controller here.
 // All this logic will automatically be available in application.js.

app.students = {

  displayOptions: function () {
    $('.student-table-info-options div').on('click', function () {

      $(this).next().toggleClass('active');
    });
  }
}

// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.

app.rights = {

  assignRights: function() {
    var dropZones = dragula([document.querySelector('#new-rights-list')]);
    var rights = document.querySelectorAll('div[id*="right-list"]');

    for (var i = 0; i < rights.length; i++) {
      dropZones.containers.push(rights[i]);
    }

    dropZones.on('drop', function(el) {

      if (!$(el).closest('div[id="new-rights-list"]').length) {
        var assignmentId = el.id.split('-')[1];
        var rightId = $(el).closest('div[id*="therightid"]').attr('id').split('-')[1];
        $.ajax({
          url: '/rights/assign/' + assignmentId + '/' + rightId,
          type: 'PATCH',
          success: function(data) {
            $('#right-row' + rightId).html(data);
          },
          error: function(request, error) {
            console.log(error)
            console.log(request)
          }
        })
      }

    })
  }
}

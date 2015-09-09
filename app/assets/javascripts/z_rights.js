// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.

app.rights = {

  assignRights: function() {
    
    $('.right-list').sortable({
      revert: true
    });
    
    $('#new-rights-list .new-right-list-container').draggable({
      connectToSortable: ".right-list",
      revert: 'invalid',
      stop: function(el) {
        if ($(el.target).closest('.right-list').length) {
          var assignmentId = el.target.id.split('-')[1];
          var rightId = $(el.target).closest('div[id*="therightid"]').attr('id').split('-')[1];
          
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
          }).done(function() {
            app.rights.assignRights();
          })
        }
      }
    })
    
  }
}

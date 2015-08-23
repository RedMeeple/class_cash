// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.

app.rights = {

  assignRights: function() {
    
    var newRightsList = document.querySelector('#new-rights-list');
    var rightList = document.querySelectorAll('div[id*="right-list"]');
    var rightTitle = document.querySelectorAll('.right-title');
    
    var arr = [];
    
    arr.push(newRightsList);
    
    for (var i = 0; i < rightList.length; i++) {
      arr.push(rightList[i]);
    }
    
    for (var i = 0; i < rightTitle.length; i++) {
      arr.push(rightTitle[i]);
    }
    
    dragula(arr, {
      
      invalid: function(el, target) {
        return el.tagName === 'I';
      },
      
      accepts: function(el, target, source, sibling) {
        return target.className !== 'right-title';
      }
      
      
    }).on('drop', function(el) {
      
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
        });
        
      }
      
    });
    
  }
}

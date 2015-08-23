// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.

app.rights = {

  assignRights: function() {
    
    var newRightsList = document.querySelector('#new-rights-list');
    var rightList = document.querySelectorAll('.right-list');
    var rightTitle = document.querySelectorAll('.right-title');
    
    function buildArray(args) {
      var arr = [];
      
      for (var i = 0; i < arguments.length; i++) {
        if (arguments[i].length > 1) {
          for (j = 0; j < arguments[i].length; j++) {
            arr.push(arguments[i][j]);
          }
        } else {
          arr.push(arguments[i]);
        }
      }
      
      return arr;
    }
    
    
    dragula(buildArray(newRightsList, rightList, rightTitle), {
      
      moves: function(el, source, handle) {
        return source.id === 'new-rights-list';
      },
      
      accepts: function(el, target, source, sibling) {
        return target.id !== 'new-rights-list';
      },
      
      revertOnSpill: true
      
    }).on('drop', function(el, target, source) {
      
      var assignmentId = el.id.split('-')[1];
      var rightId = $(el).closest('div[id*="therightid"]').attr('id').split('-')[1];
      
      if ($(el).closest('.right-title').length) {
        window.setTimeout(function() {
          $(el).remove();
        }, 1);
        
        $(source).next('.right-list').append(el);
      }
      
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
        
      
    }).on('over', function(el, container, source) {
      if (container.className === 'right-title') {
        console.log('hi');
      }
    })
    
  }
}

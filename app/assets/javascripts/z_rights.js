// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.

app.rights = {
  
  assignRights: function() {
    var dropZones = dragula([document.querySelector('#new-rights-list')]);
    var rights = document.querySelectorAll('ul[id*="right-list"]');
    
    for (var i = 0; i < rights.length; i++) {
      dropZones.containers.push(rights[i]);
    }
  }
}
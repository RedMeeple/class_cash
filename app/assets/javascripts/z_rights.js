// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.

app.rights = {
  
  assignRights: function() {
    dragula([document.querySelector('#rights-list'), document.querySelector('#new-rights-list')]);
  }
}
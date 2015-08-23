// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.

app.application = {
  
  navBar: function() {
    
    var path = $(location).attr('pathname').split('/')[1];
    var navLinks = $('.top-nav-ul a');
    var pathNames = [
      'students',
      'jobs',
      'awards',
      'transactions',
      'loans',
      'rights'
    ];
    
    $(navLinks).removeClass('active-page');
    
    for (var i = 0; i < navLinks.length; i++) {
      
      if (path === $(navLinks[i]).attr('href').split('/')[1]) {
        $(navLinks[i]).addClass('active-page');
      }
      
    }
    
    
  }
  
}
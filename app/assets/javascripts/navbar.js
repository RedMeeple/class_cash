app.navbar = {
  
  hamburger: function () {
    $('.menu-btn').click(function () {
    $('.menu-responsive').toggleClass('expand')
    });
  },
  
  removeBurger: function () {
    $('.navigation').remove();
  },
  
  homeLink: function (str) {
    str.append(
      '<li><a class="home" href="/">Home</a></li>'
    );
  },
  
  newStudentLink: function (str) {
    str.append(
      '<li><a class="add-new-student" href="/students/new">Add New Student</a></li>'
    );
  },
  
  editStudentLink: function (str) {
    str.append(
      '<li><a class="edit" href="' + $(location).attr('pathname') + '/edit">Edit</a></li>'
    );
  },
  
}
jQuery(document).ready(function($) {
  // hover dropdown menu
  $(function() {
    $('.dropdown').hover(
        function() {
          $('.dropdown-menu', this).stop(true, true).slideToggle();
          $(this).toggleClass('open');
          $('b', this).toggleClass('caret caret-up');
        }
    );
    // The code below makes the parent menu link clickable

    $('.navbar .dropdown > a').click(function(){
               location.href = this.href;
           });
  });
});

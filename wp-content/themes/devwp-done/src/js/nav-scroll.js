jQuery(document).ready(function($) {
  //dynamic scroll to top link
  $link = '<a href="#top" class="top fas fa-angle-up"></a>';
  $('body').append($link);
  $('.top').hide();
  $(window).scroll(function() {
    if ($(this).scrollTop() > 100) {
      $('.top').fadeIn();
    } else {
      $('.top').fadeOut();
    }
  });
  $('.top').click(function(e) {
    e.preventDefault();
    $('html, body').animate({scrollTop: 0}, 400);
  });

  // Open External links in a new tab
  $('a').
      filter('[href^="http"], [href^="//"]').
      not('[href*="' + window.location.host + '"]').
      attr('rel', 'noopener noreferrer').
      attr('target', '_blank');

  // offcanvas navbar
  $('[data-toggle="offcanvas"]').on('click', function () {
    $('.offcanvas-collapse').toggleClass('open')
  })
});

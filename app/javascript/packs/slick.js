/*global $*/
$(window).on('load resize', function(){
  var wid = window.innerWidth;
  if (wid >= 800) {
    $(document).ready(function(){
      $('.slider').slick({
        centerMode: true,
        slidesToShow: 3,
        arrows: false,
        autoplay: true,
        autoplaySpeed: 1500,
        speed: 700,
      });
    });
  } 
  else {
    $(document).ready(function(){
      $('.slider').slick({
        autoplay: true,
        autoplaySpeed: 1500,
        speed: 700,
      });
    });
  }
});
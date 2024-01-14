/*global $*/
$(document).ready(function() {
  var slickOptions = {
    autoplay: true,
    autoplaySpeed: 1500,
    speed: 700
  };

  $(window).on('load resize', function() {
    var wid = window.innerWidth;
    if (wid >= 800) {
      // 800px以上の場合のオプションを追加
      $('.slider').slick('slickSetOption', 'centerMode', true, true);
      $('.slider').slick('slickSetOption', 'slidesToShow', 3, true);
      $('.slider').slick('slickSetOption', 'arrows', false, true);
    } else {
      // 800px未満の場合のオプションを追加
      $('.slider').slick('slickSetOption', 'centerMode', false, true);
      $('.slider').slick('slickSetOption', 'slidesToShow', 1, true);
      $('.slider').slick('slickSetOption', 'arrows', true, true);
    }
  });

  $('.slider').slick(slickOptions);
});
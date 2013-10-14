$(function() {
  var resizeMap = function() {
    $('#map').height($(window).height() - $('#footer').height());
  };
  resizeMap();
  $(window).resize(function(e) {
    resizeMap();
  });
});

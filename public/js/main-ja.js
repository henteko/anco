$(function() {
  $.get('README/README-ja.md', function(data) {
    $('body').html(marked(data));
  });
});

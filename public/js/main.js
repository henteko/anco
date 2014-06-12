$(function() {
  $.get('README/README.md', function(data) {
    $('body').html(marked(data));
  });
});

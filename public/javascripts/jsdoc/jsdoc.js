jQuery(document).ready(function($) {
  var findClassInput = $('#find_class'); 

  function filterClasses(filter) {
    var filter= $.trim(filter.toLowerCase()),
        classTree = $('#class_tree'),
        branches = classTree.find('li');

    branches.each(function(i, el) {
      var $el = $(el);
      if(!filter || $el.text().toLowerCase().indexOf(filter) > -1) {
        $el.css('display', 'block');
      } else {
        $el.css('display', 'none');
      }
    });
  }

  findClassInput.bind('keyup change search paste cut copy dragend', function(evt) {
    filterClasses(evt.target.value);
  });
});


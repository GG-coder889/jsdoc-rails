jQuery(document).ready(function($) {
  var findClassInput = $('#find_class'); 

  function filterClasses(filter) {
    var filter= $.trim(filter.toLowerCase()),
        classTree = $('#class_tree'),
        branches = classTree.find('li');

    var matched = [];
    branches.each(function(i, el) {
      // Already matched the parent of this node
      if (matched.indexOf(el) > -1) {
        return;
      }
      var $el = $(el),
          txt = $.trim(el.innerText || el.textContent).toLowerCase(),
          label = txt.split('\n')[0];


      if (!filter || txt.indexOf(filter) > -1) {
        if (label.indexOf(filter) > -1) {
          $el.find('li').each(function(j, child) {
            matched.push(child);
            $(child).css('display', 'block');
          });
        }
        $el.css('display', 'block');
        matched.push(el);
      } else {
        $el.css('display', 'none');
      }
    });
  }

  findClassInput.bind('keyup change search paste cut copy dragend', function(evt) {
    filterClasses(evt.target.value);
  });

  $(window).scroll(function() {
    $aside = $('body > aside');
    if (!$aside[0]) {
        return;
    }
    if (!$aside[0].originalTop) {
      $aside[0].originalTop = parseInt($aside.css('top'), 10)
    }
  
    var ot = $aside[0].originalTop,
        scrollTop = $(window).scrollTop();

    if (scrollTop < 0) {
        scrollTop = 0;
    }
    var newTop = Math.max(ot - scrollTop, 20);
  
    $('body > aside').css('top', newTop);
  });
});



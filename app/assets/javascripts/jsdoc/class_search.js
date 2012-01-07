$(function () {
  var findClassInput = $('#find_class')
  function filterClasses(filter) {
    var filter= $.trim(filter.toLowerCase())
      , classTree = $('#class_tree')
      , branches = classTree.find('li')

    var matched = []
    branches.each(function(i, el) {
      // Already matched the parent of this node
      if (matched.indexOf(el) > -1) {
        return
      }
      var $el = $(el)
        , txt = $.trim(el.innerText || el.textContent).toLowerCase()
        , label = txt.split('\n')[0]


      if (!filter || txt.indexOf(filter) > -1) {
        if (label.indexOf(filter) > -1) {
          $el.find('li').each(function(j, child) {
            matched.push(child)
            $(child).show()
            $(child).parents().show()
            $(child).parents('.collapsed + ul').each(function (k, collapsed) {
                var $a = $(collapsed).siblings('a')
                $(collapsed).show()
                $a.removeClass('collapsed')
                $a.addClass('expanded')
            })
          })
        }
        $el.show()
        matched.push(el)
      } else {
        $el.hide()
      }
    })
  }

  findClassInput.bind('keyup change search paste cut copy dragend', function(evt) {
    filterClasses(evt.target.value)
  })
})

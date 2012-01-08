$(function () {
    'use strict'

    var leaveTimer
    function delayedLeave (e) {
        if (leaveTimer) clearTimeout(leaveTimer)

        leaveTimer = setTimeout(hideMenus, 250)
    }

    function hideMenus () {
        var $links = $('#wrapper .toolbar > ul > li > a')
          , $menus = $('#wrapper .toolbar > ul > li > a + ul')

        $menus.hide()
        $menus.siblings('a').removeClass('hover')
    }

    function showMenu (menu) {
        var $links = $('#wrapper .toolbar > ul > li > a')
          , $menus = $('#wrapper .toolbar > ul > li > a + ul')

        $(menu).show()
        $(menu).siblings('a').addClass('hover')
    }


    var $links = $('#wrapper .toolbar > ul > li > a')
      , $menus = $('#wrapper .toolbar > ul > li > a + ul')

    $links.live('mouseenter', function (e) {
        if (leaveTimer) clearTimeout(leaveTimer)

        hideMenus()
        showMenu($(this).siblings('ul')[0])
    })
    $menus.live('mouseenter', function (e) {
        if (leaveTimer) clearTimeout(leaveTimer)
    })

    $links.live('mouseleave', delayedLeave)
    $menus.live('mouseleave', delayedLeave)
})

$(function () {
    $.toggleBranch = function (branch, callback) {
        if ($(branch).siblings('ul').length == 0) {
            callback()
            return
        }
        $(branch).toggleClass('collapsed')
        $(branch).toggleClass('expanded')
        $(branch).siblings('ul').slideToggle(callback)
    }

    $('.tree .namespace > ul').siblings('a').addClass('collapsed')
    $('.tree .namespace > ul').hide()
    $('.tree .namespace > a').bind('click', function (e) {
        console.log()
        var pad = $(this).outerWidth() - $(this).width()
        if (e.offsetX < 20 + pad) {
            if (e.offsetX > pad) {
                $.toggleBranch(this)
            }
            e.preventDefault()
            e.stopPropagation()
        }
    })
})

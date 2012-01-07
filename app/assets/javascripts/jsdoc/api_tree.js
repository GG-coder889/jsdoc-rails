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
    $('.tree .namespace > a').bind('click', function () { $.toggleBranch(this) })
})

$(function () {
    function toggleMember (e) {
        var $td = $(e.target).parent().parent()
        $td.toggleClass('expanded')
        if ($td.hasClass('expanded')) {
            $td.removeClass('collapsed')
        } else {
            $td.addClass('collapsed')
        }
    }
    function expandMember (e) {
        var $td = $(e.target).parent().parent()
        $td.addClass('expanded')
        $td.removeClass('collapsed')
    }

    $('.expander > a').live('click', function (e) { toggleMember(e); e.preventDefault() })
    $('.members tr .member_link').live('click', expandMember)

    // Get target and add expanded flag to it
    if (location.hash) {
        var $tr = $(location.hash)
        if (!$tr.hasClass('collapsed')) {
            $tr.addClass('expanded')
        }
    }
})

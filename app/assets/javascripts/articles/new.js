$(document).ready(function(){
    var $tag_sub_tags_list = $('#tag-sub-tags-list');

    $tag_sub_tags_list.on('click', '.add-new-sub-tag', function(evt){
        var $sub_tag_list = $(this).parent().find('.sub-tag-list').last().clone();
        $sub_tag_list.find('.sub-tag-ip').val('');

        $(this).parent().find('.sub-tag-list-cont').append($sub_tag_list);
        evt.stopImmediatePropagation();
    });

    $tag_sub_tags_list.on('click', '.add-new-tag', function(evt){
        var $tag_ips = $(this).parent().find('.tag-ip');
        var $sub_tag_ips = $(this).parent().find('.sub-tag-ip');

        var $new_tag_lists = '<div class="tag-cont"><span class="add-new-tag">Add tag</span>' +
            '<label class="f-label field-required" for="article_tags">Tags</label>' +
            replaceNameAndID($tag_ips) +
            '<br/><span class="add-new-sub-tag">Add sub tag</span><ul class="sub-tag-list-cont">' +
            '<li class="sub-tag-list">' +
            replaceNameAndID($sub_tag_ips) +
            '</li></ul></div>';

        $tag_sub_tags_list.append($new_tag_lists);

        evt.stopImmediatePropagation();
    });
});


function replaceNameAndID(input_elements) {
    var $last_input_ip = input_elements.last().clone();

    var replace_number = parseInt($last_input_ip.attr('id').match(/\d+/)[0]) + 1;

    $last_input_ip.attr('id', $last_input_ip.attr('id').replace(/\d/, replace_number));
    $last_input_ip.attr('name', $last_input_ip.attr('name').replace(/\d/, replace_number));
    $last_input_ip.val('');

    return $last_input_ip.prop('outerHTML');
}

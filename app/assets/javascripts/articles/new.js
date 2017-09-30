$(document).ready(function(){
    var $tag_sub_tags_list = $('#tag-sub-tags-list');
    var $tag_template = $('<input type="text" name="article[tags][1][name]" id="article_tags_1_name" value="" class="tag-ip">');
    var $sub_tag_template = $('<input type="text" name="article[tags][1][sub_tags][]" id="article_tags_1_sub_tags_" value="" class="sub-tag-ip">');

    $tag_sub_tags_list.on('click', '.remove-tag', function(evt){
        $(this).parent().remove();

        evt.stopImmediatePropagation();
    });

    $tag_sub_tags_list.on('click', '.remove-sub-tag', function(evt){
        var sub_tags = $(this).parent().find('.sub-tag-list');
        sub_tags.last().remove();

        if(1 === sub_tags.length) {
            $(this).hide();
        }

        evt.stopImmediatePropagation();
    });

    $tag_sub_tags_list.on('click', '.add-new-sub-tag', function(evt){
        var $sub_tag_list = $(this).parent().find('.sub-tag-list').last().clone();

        if(!$sub_tag_list[0]) {
            $sub_tag_list = '<li class="sub-tag-list">' +
                '<label class="f-label field-required" for="article_sub_tag">Sub tag</label> <br>' +
                replaceNameAndID($(this).parent().find('.tag-ip'), $sub_tag_template) +
                '</li></ul>'

            $(this).parent().find('.remove-sub-tag').show();
        } else {
            $sub_tag_list.find('.sub-tag-ip').val('');
        }

        $(this).parent().find('.sub-tag-list-cont').append($sub_tag_list);
        evt.stopImmediatePropagation();
    });

    $('.new-article').on('click', '.add-new-tag', function(evt){
        var $last_tag_container = $('#tag-sub-tags-list').find('.tag-cont').last();
        var $tag_ips = $last_tag_container.find('.tag-ip');
        var $sub_tag_ips = $last_tag_container.find('.sub-tag-ip');

        var $new_tag_lists = '<div class="tag-cont"><span class="tag-actions remove-tag">remove tag </span>' +
            '<label class="f-label field-required" for="article_tags">Tag</label><br>' +
            replaceNameAndID($tag_ips, $tag_template) +
            '<br/><span class="tag-actions add-new-sub-tag">Add sub tag</span><span class="tag-actions remove-sub-tag">remove sub tag</span><ul class="sub-tag-list-cont">' +
            '<li class="sub-tag-list">' +
            '<label class="f-label field-required" for="article_sub_tag">Sub tag</label> <br>' +
            replaceNameAndID($sub_tag_ips, $sub_tag_template) +
            '</li></ul></div>';

        $tag_sub_tags_list.append($new_tag_lists);

        evt.stopImmediatePropagation();
    });
});


function replaceNameAndID(input_elements, template) {
    var $last_input_ip = input_elements.last().clone();

    var replace_number = 1;
    var id_attr = $last_input_ip.attr('id');
    if(id_attr && parseInt(id_attr.match(/\d+/)[0])) {
        replace_number = parseInt(id_attr.match(/\d+/)[0]) + 1;
    }

    template.attr('id', template.attr('id').replace(/\d/, replace_number));
    template.attr('name', template.attr('name').replace(/\d/, replace_number));

    return template.prop('outerHTML');
}

API_URL = '/api/';

api_call_id = 1
function api(method, data, callback)
{
    api_call_id++;
    var method_url = API_URL + method + "/";
    data['call_id'] = api_call_id;
    $.post(method_url, data, callback, 'json');
    return api_call_id;
}

$(function(){
    $('.licon').each(function(){
        var $icon = $(this);
        var icon_id = $icon.attr('id').split('_')[1];
        $icon.find('a.edit-link:first').click(function(){
            $(this).hide();
            $icon.children('.desc').children().hide();
            $icon.find('form').show();
            return false;
        });
        $icon.find('.button.cancel').click(function(){
            $icon.children().show();
            $icon.children('.desc').children().show();
            $icon.find('form').hide();
            return false;
        });
        $icon.find('.button.ok').click(function(){
            var $form = $icon.find('form:first');

            var icon = {};
            $form.find('input,textarea').each(function(i, el){
                var $el = $(el);
                icon[$el.attr('name')] = $el.val();
            });
            icon['username'] = $('input[name=username]').val();
            icon['desktop_slug'] = $('input[name=desktop_slug]').val();

            api('set_icon', icon, function(remote){

            });

            $icon.find('h1 a,h2 a,h3 a').text(icon['name']);
            $icon.find('p.notes').text(icon['notes']);
            $icon.find('pre').text(icon['url']);
            $icon.find('a.ilink').attr('href', icon['url']);

            $icon.children().show();
            $icon.children('.desc').children().show();
            $icon.find('form').hide();

        });

    });

    $('#search').keypress(function(){
        var $search = $(this);
        setTimeout( function() {
            var s = $search.val().toLowerCase();
            $('.licon').each(function(i, icon){
                var $icon = $(icon);
                var show = $icon.find('input.searchname').val().indexOf(s) != -1;
                if (show) {
                    $icon.parentsUntil('li').parent().show();
                }
                $icon.toggle(show);
            });
            $('.stack-list').each(function(i, sl){
                var $sl = $(sl);
                if ($sl.find('li:visible').length == 0) {
                    $sl.parent().hide();
                }
            });
        }, 20);

    });
    $('.search-box .clear-filter').click(function(){
        $('#search').val('');
        $('.licon').show();
    });

});
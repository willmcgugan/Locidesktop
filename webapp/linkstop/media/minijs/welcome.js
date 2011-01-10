max_top_urls = 30;
max_attempts = 20;
url_chunk_size = 10;

function icon_selection()
{
    var $icons = $('#auto-icons li');
    $('#welcome-throbber').addClass('complete');
    $('#welcome-throbber').hide();
    $('#scan-complete').show();

    function update_count()
    {
        var count = $('#auto-icons li.selected').length;
        $('#scan-complete .count').html("({{ count }} selected)".f({count:count}));
    }

    $icons.addClass('selected').addClass('clickable');
    var $buttons = $('#auto-buttons');
    $buttons.fadeIn();

    $buttons.find('.cancel').click(function(){
       window.location.href = '/';
    });

    $buttons.find('.ok').click(function(){
        var selected_urls = [];
        $('#auto-icons li.selected').each(function(i, icon){
            var $icon = $(icon);
            selected_urls.push($icon.find('input').val());
        });

        if (selected_urls.length==0)
        {
            window.location.href= '/new/';
            return false;
        }

        $.post('/api/set_session_icons/', {urls:selected_urls.join('|')}, function(remote){
            window.location.href=remote.response.fwd_url;
        }, 'json');
        return true;
    });

    update_count();

    $icons.click(function(){
       $(this).toggleClass('selected');
       update_count();
    });
}

$(function(){

    $('#welcome-options .create-desktop:first').click(function(){
        var $this = $(this);

        $this.addClass('active');
        $('#welcome-options .option').not(this).css('visibility', 'hidden');
        window.location.href="/new/";

    });

    $('#welcome-options .auto-desktop:first').click(function(){

        var $this = $(this);
        if ($this.hasClass('active')) {
            return;
        }

        $this.addClass('active');
        $('#welcome-options .option').not(this).fadeOut();
        $('#footer').fadeOut();


        $('#welcome-options > .inner').animate({'marginTop':'20px', 'top': '1%', 'easing':'swing', duration:'slow'}, 'slow', function(){
            var $this = $(this);
            $this.find('#auto-desktop-container').css('top', '0px').show();

            var url_count = 0;
            var top_url_position = 0;

            $('body').append('<div id="topurls" style="height:0px;overflow:hidden;"></div>')
            var $topurls = $('#topurls');

            var $icons_list = $('#auto-icons');

            function get_top_urls(remote)
            {
                var urls = remote.response.urls;
                var html=[];
                for (var i = 0; i < urls.length; i++) {
                    html.push('<a href="http://' + urls[i] +'"></a>');
                }
                $topurls.append(html.join(''));


                var visited_html = [];
                var $found = $("span.found");
                var newly_found = [];
                var newly_found_map = {};
                $.each($topurls.find('a'), function(i, a){
                    if ($(a).css('text-decoration') == 'line-through')
                    {
                        var url = a.href.slice(7, a.href.length-1);

                        $icons_list.append('<li id="topurl{{ url_count }}"><div class="sq32"><img src="/media/iconsets/crystal_project/32x32/apps/agt_web.png"/></div>{{ url }}</li>'.f({url:url, url_count:url_count}));
                        var $icon = $icons_list.find("li#topurl" + url_count);

                        $icon.append('<input type="hidden" name="url" value="{{ url }}" />'.f({url:url}) );

                        $icons_list[0].scrollTop = $icons_list[0].scrollHeight;

                        newly_found_map[url] = $icon;
                        newly_found.push(url);

                        ++url_count;

                        $found.html("({{ count }} found)".f({count:url_count}));


                        if( url_count>=max_top_urls) return false;
                        return true
                    }
                    return true;
                });

                if(newly_found.length)
                {
                    var urls = newly_found.join('|');
                    $.post('/api/get_favicons/', {urls:urls, size:32}, function(remote){

                        $.each(remote.response.urls, function(i, icon_url){

                            var $url_icon = newly_found_map[icon_url.url];
                            dynamic_preload(icon_url.icon_url, function(){
                               $url_icon.find('img').attr('src', icon_url.icon_url);
                            });

                        });

                    }, 'json');
                }

                $topurls.children().remove();

                setTimeout(function(){
                    if(url_count<max_top_urls && ++attempts<max_attempts)
                    {
                        top_url_position+= url_chunk_size;
                        url_chunk_size += 50;
                        $.post('/api/get_top_urls/', {start:top_url_position, count:url_chunk_size}, get_top_urls, 'json');
                    }
                    else
                    {
                        icon_selection();
                    }
                }, newly_found.length ? 500 : 100);

            }

            attempts = 0;
            $.post('/api/get_top_urls/', {start:top_url_position, count:url_chunk_size}, get_top_urls, 'json');

        });

    });


});

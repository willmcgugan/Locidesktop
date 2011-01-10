ajax_get_top_urls = "/api/get_top_urls/"

function top_urls(remote)
{
    var urls = remote.response.urls;
    $('body').append('<div id="topurls" style="height:0px;overflow:hidden;"></div>')
    var $topurls = $('#topurls');
    var html=[];
    for (var i = 0; i < urls.length; i++)
    {
        html.push('<a href="http://' + urls[i] +'"></a>');
    }
    $topurls.append(html.join(''));

    var $visited = $('#visited_urls');
    var visited = [];
    var visited_html = [];

    $.each($topurls.find('a'), function(i, a){
        if ($(a).css('text-decoration') == 'line-through')
        {
            var url=a.href;
            visited.push(url);
            visited_html.push('<li>url</li>'.replace('url', url));
        }
    });
    $visited.html(visited_html.join(''));
    $topurls.remove()

}

$(function(){

    $.post(ajax_get_top_urls, {count:1000*3}, top_urls, 'json');

});
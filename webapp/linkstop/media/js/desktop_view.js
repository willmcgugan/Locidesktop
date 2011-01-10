SIMPLE_ALPHA = !jQuery.support.opacity;
NOTES_ANIM = !SIMPLE_ALPHA;

icon_template =

        '<div class="notes" id="notes-{{ icon_id }}"><div class="content">{{ notes }}</div><div class="end"></div></div>' +

        '<div class="icon {{ icon_id }}" id="{{ icon_id }}" style="width:{{ icon_width }}px;">' +

        '<div class="inner"  name="{{ icon_id }}" title="{{ description }}">' +

            '<div class="handle" name="{{ icon_id }}"'+
                'style="margin:0 auto;width:{{ icon_size }}px;height:{{ icon_size }}px;">' +
                //'<a href="{{ url }}" style="width:100%;height:100%;display:block;background-image:url({{ img_url }});" target="_blank"><span></span></a>' +
                //'<a href="{{ url }}" target="_blank"> <img src="{{ img_url }}" style="padding:0px;margin:0px;width:100%;height:100%;" /> </a>' +
            '</div>' +

            '<div class="icon-label">' +
                '<a href="{{ url }}" target="_blank">{{ name }}</a>' +
            '</div>' +

            '<div class="search-box">' +
            '<input name="search-{{ icon_id }}">' +
            '</div>' +


        '</div>' +

        '</div>';

icon_img_template = '<a href="{{ url }}" target="_blank"> <img src="{{ img_url }}" style="padding:0px;margin:0px;width:100%;height:100%;" /> </a>';

desktop_label_template = '<div class="desktop-label"><a href="{{ url }}" title="View this desktop">{{ name }}</a></div>';

_username = null;
_desktop_slug = null;
fade_notes_timeout = null

function clock()
{
    return new Date().getTime();
}

String.prototype.f = function(data){
    var template = this.toString();
    var rendered_template = template.replace( /{{\s*(.*?)\s*}}/g, function(m, n) {
        var node = data;
        $.each(n.split('.'), function(i, symbol){
            node = node[symbol] || '';
        });
        return node;

    });

    return rendered_template;
}

function desktop_api(method, data, callback)
{
    var method_url = '/api/' + method + '/';
    return $.post(method_url, data, callback, 'json');
}

function pos_css(x, y)
{
    return {left:x, top:y};
}

function move_icon(icon, x, y)
{
    icon.$icon.css({top:y+'px', left:x+'px'});
}

function animate_icon(icon, x, y, callback)
{
    icon.$icon.animate(pos_css(x, y), 500, 'swing', callback);
}

icons = null;
open_stack = null;


function on_click(stack_id)
{
    var icon = icons[stack_id];
    if (icon.type == 'stack')
    {
        show_stack(stack_id);
        return false;
    }

    hide_stack();
    return true;
}

function hide_stack()
{
    var stack = icons[open_stack];
    if (!stack) return;
    $.each(icons, function(i, icon){
        if(open_stack == icon.stack)
        {
            icon.$icon.find('.icon-label').fadeOut();
            animate_icon(icon, stack.pos.x, stack.pos.y, function(){
                icon.$icon.hide();
            });
            icon.$icon.fadeOut();
        }
    });
    open_stack = null;
}

function get_animate_pos(icon, move_icon)
{
    var icon_offset = icon.pos;
    var x = Math.round(icon_offset.x);
    var y = Math.round(icon_offset.y);

    x += icon.handle_offset.x - move_icon.handle_offset.x;
    y += icon.handle_offset.y - move_icon.handle_offset.y;

    return {x:Math.round(x), y:Math.round(y)};
}

function show_stack(stack_id)
{
    if ($.timers.length) return;
    var stack = icons[stack_id];

    // Collapse expanded stack
    if(open_stack == stack_id)
    {
        $.each(icons, function(i, icon){
            if(stack_id == icon.stack)
            {
                icon.$icon.find('.icon-label, .search-box').fadeOut('normal');
                if (!SIMPLE_ALPHA) {
                    icon.$icon.find('.handle').fadeOut('normal');
                }
                var animate_pos = get_animate_pos(stack, icon);
                animate_icon(icon, animate_pos.x, animate_pos.y, function(){
                    icon.$icon.hide();
                });
                if (!SIMPLE_ALPHA) {
                    icon.$icon.fadeOut();
                }
            }
        });
        open_stack = null;
        return;
    }

    $.each(icons, function(i, icon){
        // Show stack

        if(icon.stack == stack_id) {


            //icon.$icon.show();
            icon.$icon.find('.search-box,.icon-label').hide();

            var animate_pos = get_animate_pos(stack, icon);
            move_icon(icon, animate_pos.x, animate_pos.y);

            icon.$icon.show();
            if (!SIMPLE_ALPHA) {
                icon.$icon.find('.handle').hide().fadeIn('fast');
            }

            animate_icon(icon, icon.stack_pos.x, icon.stack_pos.y, function(){
                if (!SIMPLE_ALPHA) {
                    icon.$icon.find('.icon-label').fadeIn('fast');
                } else {
                    icon.$icon.find('.icon-label').show();
                }

                if (icon.search_url) {
                    icon.$icon.find('.search-box').show();
                }
            });
        }
        // Hide previously open stack
        if(open_stack && icon.stack == open_stack)
        {
            if (!SIMPLE_ALPHA) {
                icon.$icon.find('.icon-label, .search-box, .handle').fadeOut('normal');
                icon.$icon.find('.handle').fadeOut('normal');
            }
            var home_stack = icons[icon.stack];
            var animate_pos = get_animate_pos(home_stack, icon);
            animate_icon(icon, animate_pos.x, animate_pos.y, function(){
                icon.$icon.hide();
            });
            if (!SIMPLE_ALPHA) {
                icon.$icon.fadeOut();
            }
        }

    });
    open_stack = stack_id;
}

got_options = false;

function get_url(icon)
{
    if (icon.search_url)
    {
        var $search_box = icon.$icon.find('.search-box input');
        var search = $search_box.val();
        if (search) {
            var url = icon.search_url.replace('[SEARCH]', search);
        } else {
            var url = icon.url;
        }
    } else {
        var url = icon.url;
    }
    return url;
}

function show_menu(menu_name)
{
    $('#menu_'+menu_name).toggle();
    return false;
}


function render_desktop(state)
{
    if (!state) return;
    var $icon_layer = $('.icon-layer');
    current_desktop = state;
    var $window = $(window);

    show_notes_timer = null;
    hide_notes_timer = null;

    var desktop_slug_input=$('input#desktop_slug');
    var username_input=$('input#username');
    _desktop_slug = desktop_slug_input.val();
    _username = username_input.val();
    show_notes_time = null;

    $preloads = $('#preloads');
    $active_notes = null;

    var img_urls = {};

    icons = {};
    $.each(state.icons, function(i, icon) {

        var icon_identifier = icon.icon_id;

        icons[icon_identifier] = icon;
        var td=icon;

        var icon_sizes = get_icon_sizes(icon).slice();
        var display_size=icon_sizes[0];
        for (var s=0; s<icon_sizes.length; s++) {
            if (icon_sizes[s]==icon.icon_size) {
                display_size = icon_sizes[s];
            }
            if (icon_sizes[s]>icon.icon_size) {
                break;
            }
            display_size = icon_sizes[s];
        }

        td.img_url = get_img_template(icon).replace(/\[SIZE\]/g, display_size);
        var icon_width = Math.max(icon.icon_size * 1.5, 96);
        td.icon_width = icon_width;

        //td.img_url = MEDIA_URL + td.img_url;
        td.img_url = pathjoin([MEDIA_URL, td.img_url]);

        if (td.notes !== undefined) {
            td.notes = text_to_html(td.notes);
        }

        if(img_urls[td.img_url] === undefined) {
            $preloads.append('<img src="{{ img_url }}"/>'.f(td));
            img_urls[td.img_url] = true;
        }

        var html = icon_template.f(td);
        $icon_layer.append(html);

        var $icon = $('.'+icon_identifier);
        var $notes = $('#notes-' + icon_identifier);
        icon.$icon = $icon;
        icon.$notes = $notes;
        $icon.css({left:icon.pos.x, top:icon.pos.y});

        dynamic_preload(td['img_url'], function(){
           $icon.find('.handle').html(icon_img_template.f(td));
            $icon.find('.handle,.icon-label a').unbind('click').click(function(){
                return on_click(icon.icon_id);
            });
        });

        var icon_offset = $icon.offset();
        var handle_offset = $icon.find('.handle:first').offset();
        var offset_x = handle_offset.left - icon_offset.left + icon.icon_size/2;
        var offset_y = handle_offset.top - icon_offset.top + icon.icon_size/2;
        icon.handle_offset = {x:offset_x, y:offset_y};

        if (icon.type=='stack') {
            $icon.addClass('stack');
        }

        var width_overflow = Math.min(icon.icon_size * 0.5, 32);
        var icon_width = Math.max(icon.icon_size + width_overflow, 96);
        $icon.css({width:icon_width});

        if (icon.visible && !icon.stack) {
            $icon.show();
            if (icon.search_url) {
                icon.$icon.find('.search-box').show();
            }
        }

        $(document).mousemove(function(e){
            position_notes(e.pageX, e.pageY);
        });

        $icon.find('.handle,.icon-label a').unbind('click').click(function(){
            return on_click(icon.icon_id);
        });

        function position_notes(x, y)
        {
            if (!$active_notes) {
                return;
            }
            var win_width = $(window).width();
            var notes_width = $active_notes.width();
            var notes_x_offset = 10;

            if(x + notes_width + notes_x_offset >  win_width)
            {
                $active_notes.addClass('left');
                x = x - notes_width - notes_x_offset;
            } else {
                $active_notes.removeClass('left');
                x += notes_x_offset;
            }
            y-= 28;

            $active_notes.css({left:x+'px', top:y+'px'});
        }

        $icon.find('.icon-label,.handle').mousemove(function(e){

            //clearTimeout(fade_notes_timeout);
            //fade_notes_timeout = null;

            position_notes(e.pageX, e.pageY);

            if (icon.type=='stack' && open_stack != icon.icon_id) {
                show_stack(icon.icon_id);
            }

            // If no active notes displayed
            if (!$active_notes)
            {
                $('div.notes').not($notes).hide();
                if (icon.notes){
                    $active_notes = $notes;
                    if (false && !SIMPLE_ALPHA) {
                        $active_notes.fadeIn('fast');
                    } else {
                        $active_notes.show();
                    }
                }
            }
            // If a different notes is hovered
            else if ($notes !== $active_notes)
            {
                $('div.notes').not($notes).hide();

                $active_notes = $notes;
                if (icon.notes){
                    $notes.show()
                }
            }

        }).mouseout(function(e){
            if ($active_notes) {
                $active_notes.hide();
                $active_notes = null;
                /*if (fade_notes_timeout) {
                    clearTimeout(fade_notes_timeout);
                }
                var $clear_notes = $active_notes;
                fade_notes_timeout = setTimeout(function(){
                    if (false && !SIMPLE_ALPHA) {
                        $clear_notes.fadeOut('fast');
                    } else {
                        $clear_notes.hide();
                    }
                    }, 100 );
                $active_notes = null;*/
            }
        });


        $icon.find('.search-box input').change(function(e){
            var url = get_url(icon);
            $icon.find('a').attr('href', url);
        }).keyup(function(e) {

            if (e.keyCode==13) {
                window.open(get_url(icon));
            }

        }).focus(function(e){

            this.selectionStart = 0;
            this.selectionEnd = $(this).val().length;
            return false;
        });

    });

    $(document).mousedown(function(e){
        if(e.target.tagName != 'A' && e.target.tagName!= 'UL')
        {
            $('.menu').fadeOut('fast');
            e.stopPropagation();
        }

    });

}


function bind()
{

    $('.desktop-label').click(function(e){

        var $this = $(this);
        var $a = $this.find('a:first');

        if (e.target.tagName == 'A') return true;


        if ($a.attr('onclick'))
        {
            $this.find('a:first').click();
        }
        else
        {
            location.href = $a.attr('href');
        }
        return true;
    });

}

function create_desktop()
{
    function on_create_desktop(remote)
    {
        if (remote.response.result=='success') {
            window.location = remote.response.url;
        } else {
            desktop_alert("Create Desktop", remote.response.message);
        }
    }
    popup('new-desktop', {label:'Create new desktop', callback:function(){
        var desktop_name = $('#new_desktop_name').val();
        if (!desktop_name) {
            return false;
        }
        var desktop_private = $('#private_desktop').is(':checked');
        desktop_api('create_desktop', {desktop_name:desktop_name, 'private':desktop_private}, on_create_desktop);
        return true;
    }}, true );

    return false;
}


function delete_desktop()
{
    function on_delete_desktop(remote)
    {
        if (remote.response.result=='success') {
            window.location = remote.response.url;
        } else {
            desktop_alert("Delete Desktop", remote.response.message);
        }
    }
    popup('delete', {label: "Yes, delete this desktop", callback:function(){
        var desktop_slug = $('#desktop_slug').val();
        var username = $('#username').val();
        desktop_api('delete_desktop', {username:username, desktop_slug:desktop_slug}, on_delete_desktop);
    }}, true);
}


function rename_desktop()
{
    
    popup('rename-desktop', {label: "Rename this desktop", callback:function(){
        var new_name = $('#rename_desktop').val();
        var desktop_slug = $('#desktop_slug').val();
        var username = $('#username').val();
        desktop_api('rename_desktop', {username:username, desktop_slug:desktop_slug, new_name:new_name}, function(remote) {
            
            dismiss_popup();
    
            if(remote.response.result=='success') {
                window.location.href = remote.response.url;            
            } else {
                desktop_alert("Rename Desktop", remote.response.message);
            }
            
        })
    }}, true);
}

function toggle_private()
{
    function on_toggle_private(remote)
    {
        if (remote.response.result != 'success')
        {
            desktop_alert("Unable to change setting", remote.response.message);
            return;
        }
        if (remote.response.value) {
            desktop_alert("Desktop Setting Changed", "This desktop has been made <em>private</em> (only you may view this desktop).");
            $('.desktop-label.active').addClass('private');
        } else {
            desktop_alert("Desktop Setting Changed", "This desktop has been made <em>public</em> (anyone can view this desktop).");
            $('.desktop-label.active').removeClass('private');
        }
    }
    var private_desktop = $('#setting_private').val() == '1';
    var desktop_slug = $('#desktop_slug').val();
    var username = $('#username').val();
    private_desktop = !private_desktop;
    $('#setting_private').val(private_desktop? '1' : '0');

    var $private_setting_menu = $('#menu_options li.desktop-setting a');
    if (private_desktop) {
        $private_setting_menu.addClass('on').removeClass('off');
    } else {
        $private_setting_menu.addClass('off').removeClass('on');
    }

    var api_call = {    desktop_slug:desktop_slug,
                        username:username,
                        key:'private',
                        value:private_desktop };

    desktop_api('set_desktop_setting', api_call, on_toggle_private);
}

function make_homepage()
{
    $('.menu').fadeOut('fast');
    document.body.style.behavior='url(#default#homepage)';
    document.body.setHomePage(window.location.href);
}

function on_menu_click(name)
{
    if (name=='create-desktop') {
        create_desktop();
    }
    if (name=='delete-desktop') {
        delete_desktop();
    }
    if (name=='toggle-private') {
        toggle_private();
    }
    if (name=='make-homepage') {
        make_homepage();
    }
    if (name=='rename-desktop') {
        rename_desktop();
    }
}


$(document).ready(function(){

    MEDIA_URL = $('#media_url').val();

    function start()
    {
        if (!desktop_initial_state)
        {
            desktop_initial_state = {icons:{}};
        }
        render_desktop(desktop_initial_state);

        var desktop_slug = $('#desktop_slug').val();
        $('#menu_options li.disabled a').unbind('click').attr('onclick', 'return false;').click(function(){return false;});
        $('#desktop-view-links').css({'z-index':3000});
        $('#desktoplink-' + desktop_slug).addClass('active');
        bind();

        //var username = $('#username').val();
        //var desktop_slug = $('#desktop_slug').val();
        //
        //var get_query = window.location.href.split('?')[1] || '';
        //if(get_query) get_query='?'+get_query;
        //
        //var links_url = '/ajax/{{ username }}/{{ desktop_slug }}/links/{{ get_query }}'.f({username:username, desktop_slug:desktop_slug, get_query:get_query});
        //$.get(links_url, {}, function(html){
        //    $('#desktop-links').html(html);
        //    $('#desktop-view-links').fadeIn('fast');
        //    $('#desktop-view-links').css({'z-index':3000});
        //    $('#desktoplink-' + desktop_slug).addClass('active');
        //    bind();
        //});
    }
    start();

});
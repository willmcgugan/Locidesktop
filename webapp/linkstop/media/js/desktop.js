SIMPLE_ALPHA = !jQuery.support.opacity;


AUTO_COMPLETE_DELAY = 350;

AUTO_COMPLETE_DELAY = 1

KEY_DOWN = 40;
KEY_UP = 38;
KEY_RETURN = 13;
KEY_ESCAPE = 27;

DEFAULT_ICON_SIZE = 48;

function Class(definition)
{
    var prototype = definition;

    if (definition['_extends'] !== undefined)
    {
        $.each(definition['_extends'].prototype, function(k, v){

            if (prototype[k] === undefined) {
                prototype[k] = v;
            } else {
                prototype[k+'_super'] = v;
            }
        });
    }

    var constructor = definition['_init'];
    if (constructor === undefined)
    {
        constructor = function()
        {
            if (this.prototype('_init_super')) {
                this._init_super();
            }
        }
    }
    constructor.prototype = prototype;
    return constructor
}

A = new Class({
    _init:function(m)
    {
        this.m = m;
    },
    say:function()
    {
        console.log(this.m + " from A");
    }
});


B = new Class({
    _extends:A,
    _init:function(m)
    {
        this.m = m;
        this._init_super(m);
    },
    say:function()
    {
        console.log(this.m + " from B");
        this.say_super();
    }
});

//b = new B('Hai!');
//b.say();

$window = $(window);
api_call_id = 0;
preload_id= 0;

icon_template =
        '<div class="icon {{ icon_id }}" id="{{ icon_id }}" style="width:{{ icon_width }}px;">' +

        '<div class="inner">' +
            '<div class="handle" id="handle-{{ icon_id }}"' +
                'style="margin:0 auto;width:{{ icon_size }}px;height:{{ icon_size }}px;">' +

                    '<img src="{{ img_url }}" style="padding:0px;margin:0px;width:100%;height:100%;" /></div>' +

                '<div class="icon-label">' +
                    '<span class="text">{{ name }}</span>' +
                '</div>' +
                '<div class="size-labels" ><div class="size-change size-up" id="up_{{ icon_id }}"></div><div class="size-change size-down" id="down_{{ icon_id }}"></div></div>' +
                '<div class="search-box">' +
                    '<input name="search-{{ icon_id }}">' +
                '</div>' +
            '</div>' +
        '</div>';

stack_template =
    '<div id="{{ stack_id }}" class="icon stack">' +
    '<div class="stack-item"></div>' +
    '</div>'

stack_item_template = '<div class="stack-item"><img width="{{ icon_size }}" height="{{ icon_size }}" src="{{ img_url }}" /></div>'

test_state = undefined;

check_state_timeout = null;



function clock() {
    var currentTime = new Date()
    var t = currentTime.getTime() / 1000.0;
    return t;
}


function show_menu(menu_name)
{
    $('#menu_'+menu_name).toggle();
    return false;
}


dialogs = {};

function App() {

    var self = this;
    self.dragging = false;

    self.desktop = null;


}
app = new App();


Point = new Class({

    _init:function(x, y) {
        this.x = x || 0; this.y = y || 0;
    },

    clone:function() {
        return new Point(this.x, this.y);
    },

    css:function() {
        return {left:Math.round(this.x)+'px', top:Math.round(this.y)+'px'};
    },

    css_restrict:function() {
        var p = this.get_restrict().round();
        return {left:p.x+'px', top:p.y+'px'};
    },

    set:function(x, y) {
        this.x = x; this.y = y;
        return this;
    },

    set_point:function(other) {
        this.x = other.x;
        this.y = other.y;
        return this;
    },

    restrict:function(x, y) {
        this.x = Math.max(this.x, 0);
        this.y = Math.max(this.y, 0);
        return this;
    },

    minus:function(other) {
        return new Point(this.x - other.x, this.y - other.y);
    },

    subtract:function(o) {
        this.x -= o.x;
        this.y -= o.y;
        return this
    },

    plus:function(other) {
        return new Point(this.x + other.x, this.y + other.y);
    },

    add:function(o) {
        this.x += o.x;
        this.y += o.y;
        return this;
    },

    scalar_mul:function(scalar) {
        return new Point(this.x * scalar, this.y * scalar);
    },

    vector_mul:function(o) {
        return new Point(this.x * o.x, this.y * o.y);
    },

    scalar_div:function(scalar) {
        return new Point(this.x / scalar, this.y / scalar);
    },

    half:function() {
        this.x *= 0.5;
        this.y *= 0.5;
        return this;
    },

    halved:function() {
        return new Point(this.x * 0.5, this.y * 0.5);
    },

    vector_div:function(o) {
        return new Point(this.x / o.x, this.y / o.y);
    },

    min:function(o) {
        this.x = Math.min(this.x, o.x);
        this.y = Math.min(this.y, o.y);
        return this;
    },

    max:function(o) {
        this.x = Math.max(this.x, o.x);
        this.y = Math.max(this.y, o.y);
        return this;
    },

    get_min:function(other) {
        return new Point(Math.min(this.x, other.x), Math.min(this.y, other.y));
    },

    get_max:function(other) {
        return new Point(Math.max(this.x, other.x), Math.max(this.y, other.y));
    },

    get_distance:function(other) {
        var d = this.minus(other);
        return Math.sqrt(d.x*d.x + d.y*d.y);
    },

    get_length:function(other) {
        return Math.sqrt(this.x*this.x + this.y*this.y);
    },

    restrict:function() {
        this.x = Math.max(this.x, 0);
        this.y = Math.max(this.y, 0);
        return this;
    },

    get_restrict:function() {
        return new Point(Math.max(this.x, 0), Math.max(this.y, 0));
    },

    get_rounded:function() {
        return new Point(Math.round(this.x), Math.round(this.y));
    },

    round:function() {
        this.x = Math.round(this.x);
        this.y = Math.round(this.y);
        return this;
    },

    log:function()
    {
        if (console)
        {
            console.log("({{ x }}, {{ y }})".f(this))
        }
    }
});

OffsetPoint = new Class({

    _extends:Point,

    _init:function($el) {
        var offset = $el.offset();
        this.x = offset.left;
        this.y = offset.top;
    }
});

DimensionsPoint = new Class({

    _extends:Point,

    _init:function($el) {
        this.x = $el.width();
        this.y = $el.height();
    }

})

Rect = new Class({

    _init:function(p1, p2) {
        this.p1 = p1.get_min(p2);
        this.p2 = p1.get_max(p2);
        this.update();
    },

    clone: function() {
      return new Rect(this.p1.clone(), this.p2.clone());
    },

    set:function(p1, p2) {
        this.p1.set_point(p1.get_min(p2));
        this.p2.set_point(p1.get_max(p2));
        this.update();
        return this;
    },

    css:function() {
        return {left:Math.round(this.p1.x)+'px',
                top:Math.round(this.p1.y)+'px',
                width:Math.round(this.w)+'px',
                height:Math.round(this.h)+'px'};
    },

    contains_point:function(p) {
        return (p.x >= this.p1.x &&
                p.x < this.p2.x &&
                p.y >= this.p1.y &&
                p.y < this.p2.y);
    },

    get_center:function() {
        return new Point(this.p1.x + this.w / 2, this.p1.y + this.h / 2);
    },

    get_dimensions:function() {
        return new Point(this.w, this.h);
    },

    expand:function(x, y) {

        p = new Point(x, y);
        this.p1.min(p);
        this.p2.max(p);
        this.update();
        return this;
    },

    expand_rect:function(r) {
        this.p1.min(r.p1);
        this.p2.max(r.p2);
        this.update();
        return this;
    },

    grow:function(w, h) {

        this.p1.x -= w;
        this.p1.y -= h;
        this.p2.x += w;
        this.p2.y += h;
        this.update();
        return this;
    },

    update:function(r) {
        this.w = this.p2.x - this.p1.x;
        this.h = this.p2.y - this.p1.y;
    }

});

ElementRect = new Class({
    _extends: Rect,
    _init:function(el) {
        var r = el.getBoundingClientRect();
        this.p1 = new Point(r.left, r.top);
        this.p2 = new Point(r.right, r.bottom);
        this.update();
    }
})

DesktopItem = new Class({
    on_start_drag:function() {},
    on_end_drag:function() {},
    on_click:function(e) {},
    on_double_click:function() {},
    on_drop:function() {},
    on_select:function() {}
});


Icon = new Class({

    _extends: DesktopItem,

    _init:function(desktop, icon_id, name, $icon, icon_img) {
        this.desktop = desktop;
        this.name = name;
        this.icon_id = icon_id;
        this.type = 'icon';
        this.$icon = $icon;
        this.$icon_inner = $icon.find('.inner:first');
        this.$handle = $icon.find('.handle:first');

        this.pos = new Point(0, 0);
        this.stack_pos = new Point(0, 0);
        this.visible = false;
        this.title = "An Icon";
        this.selected = false;
        this.icon_img = icon_img;
        this.stack = null;
        this.update();
        this.total_mickies = new Point(0, 0);
        this.animating = false;

        this.img_url_template = '';
        this.icon_size = undefined;
        this.icon_sizes = undefined;

        this.favicon_sizes = undefined;
        this.favicon_img_url_template = '';

        this.has_favicon = false;
        this.use_favicon = false;

        this.dragging = false;
    },

    issame: function(state) {

        return( this.pos.x == state.pos.x &&
                this.pos.y == state.pos.y &&
                this.stack_pos.x == state.stack_pos.x &&
                this.stack_pos.y == state.stack_pos.y &&
                this.icon_img == state.icon_img &&
                this.icon_size == state.icon_size &&
                this.img_url_template == state.img_url_template &&
                this.selected == state.selected &&
                this.title == state.title &&
                this.visible == state.visible &&
                this.title == state.title &&
                this.favicon_img_url_template == state.favicon_img_url_template &&
                this.has_favicon == state.has_favicon &&
                this.use_favicon == state.use_favicon &&
                this.url == state.url);

    },

    get_img_url_template: function() {

        if (this.use_favicon && this.has_favicon && this.favicon_img_url_template) {
            return this.favicon_img_url_template;
        } else {
            return this.img_url_template;
        }
    },

    get_icon_sizes: function() {

        if (this.use_favicon && this.has_favicon) {
            return this.favicon_sizes;
        } else {
            return this.icon_sizes;
        }
    },

    set_new_icon: function(new_icon, icon_key) {

        var self=this;
        this.icon_key = icon_key;
        this.img_url_template = new_icon.img_url;
        this.icon_sizes = new_icon.sizes.slice();
        var has_size = false;

        $.each(self.get_icon_sizes(), function(i, size) {
           if (size==self.icon_size) {
                has_size=true;
                return false;
           }
           return true;
        });
        if (!has_size) {
            this.icon_size = 32;
        }

        this.change_size(0);
        this.update();
    },

    //set_new_icon: function(new_icon, icon_key) {
    //
    //    console.log(new_icon);
    //
    //    var self=this;
    //    this.icon_key = icon_key;
    //    this.icon_sizes = get_icon_sizes(new_icon);
    //    this.img_url_template = get_img_template(new_icon);
    //    var has_size = false;
    //    $.each(this.get_icon_sizes(), function(i, size) {
    //       if (size==self.icon_size) {
    //            has_size=true;
    //            return false;
    //       }
    //       return true;
    //    });
    //    if (!has_size) {
    //        this.icon_size = 32;
    //    }
    //
    //    this.change_size(0);
    //    this.update();
    //},

    get_dimensions:function() {
        return new Point(this.$icon[0].clientWidth,
                         this.$icon[0].clientHeight);
    },

    on_hover_icon:function(){
    },

    on_start_drag:function() {
        if (this.animating) return;
        this.move_to_top();
        this.desktop.hide_guides();
        this.total_mickies.set(0, 0);
        this.original_drag_pos = this.pos.clone();
        this.dragging = true;
        if (this.selected) {
            $.each(this.desktop.icons, function(i, icon){
                if (icon.selected) {
                    icon.dragging = true;
                    icon.original_drag_pos = icon.pos.clone();
                    icon.move_to_top();
                }
            });
        }

    },

    drag:function(mickies) {
        this.total_mickies.add(mickies);
        if (this.selected) {
            $.each(this.desktop.icons, function(i, icon){
                if (icon.selected) {
                    icon.move(mickies);
                }
            });
        }
        else this.move(mickies);

        this.desktop.highlight_hover();
    },

    on_end_drag:function()
    {
        if (this.selected) {
            $.each(this.desktop.icons, function(i, icon){
                if (icon.selected) {
                    icon.pos.restrict();
                    icon.dragging = false;
                    icon.update();
                }
            });
        }
        else
        {
            this.dragging = false;
            this.pos.restrict();
            this.update();
        }
        if (this.total_mickies.get_length()) {
            this.desktop.undo_step();
        }
        this.desktop.remove_hover_highlights();

        var p = this.pos.plus(this.handle_offset)
        var hover_icon = this.desktop.get_hover_icon(p.x, p.y);

        if (hover_icon)
        {
            hover_icon.on_drop(this);
        }

        this.desktop.show_guides();
    },

    move:function(offset) {
        this.pos.add(offset);
        this.$icon.css(this.pos.css_restrict());
    },

    move_to:function(x, y) {
        this.pos.set(x, y);
        this.$icon.css(this.pos.css_restrict());
    },

    move_visual_to:function(x, y) {
        var pos = new Point(x, y);
        this.$icon.css(pos.css_restrict());
    },


    animate_to_simple:function(x, y, speed, callback) {
        var self=this;
        var anim_pos = new Point(x, y);
        anim_pos.restrict();
        this.pos.set_point(anim_pos);

        function animate_callback()
        {
            self.animating = false;
            if(callback) callback();
            self.update();
        }
        this.animating = true;
        return this.$icon.animate(  anim_pos.css(),
                                    speed || 200,
                                    'swing',
                                    animate_callback);
    },

    animate_to:function(x, y, callback) {
        var self=this;
        var anim_pos = new Point(x, y);
        anim_pos.restrict()
        var d = this.pos.get_distance(anim_pos) * 1.2;

        this.pos.set_point(anim_pos);

        function animate_callback()
        {
            self.animating = false;
            if(callback) callback();
            self.update();
        }
        this.animating = true;
        return this.$icon.animate(  anim_pos.css(),
                                    d,
                                    'swing',
                                    animate_callback);
    },

    toggle_select:function(speed)
    {
        if (this.selected) {
            this.$icon.removeClass('selected');
            this.$icon.find('.highlight').hide();
            this.selected = false;
        }
        else {
            this.$icon.addClass('selected');
            if (speed === undefined ) {
                this.$icon.find('.highlight').show();
            } else {
                this.$icon.find('.highlight').fadeIn(speed);
            }
            this.selected = true;
            this.on_select();
        }
        return this;
    },

    select:function(speed)
    {
        this.$icon.addClass('selected');
        if (speed === undefined ) {
                this.$icon.find('.highlight').show();
            } else {
                this.$icon.find('.highlight').fadeIn(speed);
            }
        this.selected = true;
        this.on_select();
        this.desktop.state_change();
        return this;
    },

    unselect:function()
    {
        this.selected = false;
        this.$icon.removeClass('selected');
        this.$icon.find('.highlight').hide();
        this.desktop.state_change();
        return this;
    },

    setselect:function(set)
    {
        if (set) {
            this.select();
        } else {
            this.unselect();
        }
    },

    on_click:function(e)
    {
        if (this.animating) return this;
        this.toggle_select();
        return this;
    },
    //
    //move_to_top:function()
    //{
    //    var $clone_icon = this.$icon.clone();
    //    this.desktop.$desktop.find('.icon-layer:first').append($clone_icon);
    //    var $old_icon = this.$icon;
    //    //this.$icon.remove();
    //    this.$icon = $clone_icon;
    //    $old_icon.remove();
    //    this.desktop.rebind();
    //    this.$icon_inner = $clone_icon.find('.inner:first');
    //    this.$handle = $clone_icon.find('.handle:first');
    //    this.update();
    //    return this;
    //},


    move_to_top:function()
    {
        //var $clone_icon = this.$icon.clone();
        this.desktop.$desktop.find('.icon-layer:first').append(this.$icon);
        //var $old_icon = this.$icon;
        //this.$icon.remove();
        //this.$icon = $clone_icon;
        //$old_icon.remove();
        //this.desktop.rebind();
        //this.$icon_inner = $clone_icon.find('.inner:first');
        //this.$handle = $clone_icon.find('.handle:first');
        this.update();
        return this;
    },

    update:function()
    {
        if (this.dragging || this.animating) {
            return;
        }
        var icon_pos = new OffsetPoint(this.$icon);
        var handle_pos = new OffsetPoint(this.$handle);
        var handle_size = new DimensionsPoint(this.$handle);
        this.handle_offset = handle_pos.minus(icon_pos).plus( handle_size.scalar_div(2) );
        this.handle_rect = new Rect(handle_pos, handle_pos.plus(handle_size));
        this.icon_inner_size = new DimensionsPoint(this.$icon_inner)
    },

    change_size:function(dir, no_anim)
    {
        if(dir==0)
        {
            no_anim=true;
        }
        var self = this;
        var sizes = this.get_icon_sizes().slice();
        var display_sizes = sizes.slice();
        sizes.push(16, 32, 48, 64, 96, 128);
        sizes.sort(function(a,b){return a - b});
        sizes.unique();

        var icon_sizes = this.get_icon_sizes().slice();
        var n = 0;
        for (var s=0; s<sizes.length; s++) {
            if (sizes[s]==this.icon_size) break;
            n++;
        }

        this.$icon.find('.size-down,.size-up').removeClass('disabled');


        n = Math.max(0, n+dir);
        n = Math.min(n, sizes.length-1);

        if (n==0) {
            this.$icon.find('.size-down').addClass('disabled');
        } else if (n==sizes.length-1) {
            this.$icon.find('.size-up').addClass('disabled');
        }


        if (dir!=0 && this.icon_size == sizes[n]) {
            this.update();
            return;
        }
        this.icon_size = sizes[n];
        var width_overflow = Math.min(this.icon_size * 0.5, 32);
        var icon_width = Math.max(this.icon_size + width_overflow, 96);

        var display_size = display_sizes[0];
        for (var s=0; s<display_sizes.length; s++) {
            if (display_sizes[s] == this.icon_size) {
                display_size = display_sizes[s];
                break;
            }
            if (display_sizes[s] > this.icon_size) {
                break;
            }
            display_size = display_sizes[s];
        }

        var img_url = this.get_img_url_template().replace(/\[SIZE\]/g, display_size);

        this.img_url = pathjoin([MEDIA_URL, img_url]);
        var $handle = this.$icon.find('.handle');

        if (no_anim)
        {
             this.$icon.css({width:icon_width});
             $handle.find('img').attr('src', self.img_url);
             $handle.css({width:this.icon_size, height:this.icon_size});

        } else {

            this.$icon.animate({width:icon_width}, 150, 'swing', function(){
                self.update();
                self.desktop.update_guides();
            });

            dynamic_preload(this.img_url, function(){
                $handle.find('img').attr('src', self.img_url);
            });

            $handle.animate({width:this.icon_size, height:this.icon_size}, 150, 'swing', function(){
                self.update();
                self.desktop.update_guides();
            });
        }

        if (!self.visible) {
            self.$icon.hide();
        }
        this.update();

    },

    get_size:function()
    {
        return this.icon_inner_size;
    },

    calculate_handle_rect:function()
    {
        var $handle = this.$icon.find('.handle:first');
        var handle_offset = new OffsetPoint($handle);
        var handle_size = new DimensionsPoint($handle);

        this.handle_rect = new Rect(handle_offset, handle_offset.plus(handle_size));
    },

    get_handle_rect:function()
    {
        return this.handle_rect;
    },

    state_vars:[    'type',
                        'name',
                        'icon_id',
                        'icon_img',
                        'icon_key',
                        'visible',
                        'title',
                        'selected',
                        'stack',
                        'pos',
                        'stack_pos',
                        'stacked',
                        'url',
                        'search_url',
                        'description',
                        'notes',
                        'img_url_template',
                        'icon_size',
                        'icon_sizes',

                        'has_favicon',
                        'use_favicon',
                        'favicon_img_url_template',
                        'favicon_sizes',


                        ],

    get_state:function()
    {
        var self=this;
        var state = {};
        $.each(this.state_vars, function(i, v){
            if (self[v] && self[v].clone) {
                state[v] = self[v].clone();
            } else {
                state[v] = self[v];
            }
        })

        return state;
    },

    set_state:function(state)
    {
        var self=this;
        this.pos = new Point(0, 0);
        this.icon_size = 32;
        this.icon_sizes = [32];
        $.each(this.state_vars, function(i, v){
            if (state[v] !== undefined) {
                self[v] = state[v];
            }
            if (state[v] && (v=='pos' || v=='stack_pos')) {
                self[v] = new Point(state[v].x, state[v].y);
            }
        });
        this.set_name(state.name);
        this.$icon.find('.search-box')[state.search_url ? 'show' : 'hide']();

        if (this.visible) {
            this.$icon.show();
        } else {
            this.$icon.hide();
        }
        this.$icon.find('.icon-label .text').html(this.name);
        if (this.selected) this.select();
        this.update();
        return this;
    },

    set_name: function(name)
    {
        this.name=name;
        this.$icon.find('.icon-label .text').html(this.name);
    },

    make_invisible:function(speed)
    {
        if (speed===undefined) {
            this.$icon.hide();
        } else {
            this.$icon.fadeOut(speed);
        }
        this.visible = false;
        return this;
    },

    make_visible:function(speed)
    {
        if (speed===undefined) {
            this.$icon.show();
        } else {
            this.$icon.fadeIn(speed);
        }
        this.visible = true;
        this.update();
        return this;
    },

    hide_label:function() {
        this.$icon.find('.icon-label:first,.search-box').hide();
    },

    show_label:function() {
        this.$icon.find('.icon-label:first').show();
        if (this.search_url) {
            this.$icon.find('.search-box').show();
        }
    },

    delete_icon:function() {
        this.$icon.fadeOut('fast', function() {
            $(this).remove();
        });
    }
});

Stack = new Class({

   _extends:Icon,

    _init:function(desktop, icon_id, name, $icon, icon_img)
    {
        this._init_super(desktop, icon_id, name, $icon, icon_img);
        this.type = 'stack';
        this.stacked = false;
    },

    is_animating:function()
    {
        var self = this;
        if (this.animating) return true;
        var animating = false;
        $.each(this.desktop.icons, function(i, icon){
            if (icon.stack == self.icon_id) {
                if (icon.animating) {
                    animating = true;
                    return false;
                }
            }
            return true;
        })
        return animating;
    },

    get_animate_pos:function(icon)
    {
        this.$icon.offset();

        var handle_offset = this.$icon.find('.handle').offset();
        var handle_pos = new Point(handle_offset.left, handle_offset.top);
        var handle_dimensions = new Point(this.icon_size, this.icon_size);
        handle_pos.add(handle_dimensions.scalar_div(2));

        var icon_dimensions = new Point(icon.$icon.width(), icon.$icon.height());
        handle_pos.subtract(icon_dimensions.scalar_div(2));
        handle_pos.round();
        return handle_pos;
    },

    build:function(icons)
    {
        var self = this;
        var num_icons = icons.length;
        var count = 0;
        $.each(icons, function(i, icon){
            icon.unselect();
            if (icon.type == 'stack') return true;
            icon.stack = self.icon_id;
            icon.stack_pos = icon.pos.clone();
            icon.hide_label();
            icon.visible = false;

            var animate_pos = self.get_animate_pos(icon);
            icon.animate_to(animate_pos.x, animate_pos.y, function(){
                icon.hide_label();
                icon.make_invisible();
                if (i==0) self.make_visible('fast');
                if(++count==num_icons) self.select();
            });
            return true;
        });
        this.stacked = true;
    },

    unstack:function()
    {
        if (!this.stacked) return false;

        var self = this;
        var stack_icons = [];
        $.each(this.desktop.icons, function(i, icon){
            if (icon.stack == self.icon_id) {

                var new_pos = icon.stack_pos.clone();
                stack_icons.push([icon, new_pos]);
            }
        });

        if(!stack_icons.length) return false;

        this.stacked = false;

        var min_pos = stack_icons[0][1].clone();
        $.each(stack_icons, function(i, stack_icon){
            min_pos.set_point( min_pos.get_min(stack_icon[1]) );
        });

        self.desktop.unselect_all();
        $.each(stack_icons, function(i, stack_icon){

            var icon = stack_icon[0];

            var animate_pos = self.get_animate_pos(icon);
            var pos = animate_pos;

            var pos = stack_icon[1];
            if (min_pos.x < 0) pos.x -= min_pos.x;
            if (min_pos.y < 0) pos.y -= min_pos.y;

            icon.move_to(animate_pos.x, animate_pos.y);
            icon.visible = true;
            icon.make_visible();
            icon.hide_label();
            icon.move_to_top();
            icon.unselect();
            icon.animate_to_simple(pos.x, pos.y, 'normal', function() {
                icon.show_label();
                icon.update();
                icon.select();
            });

        });
        return true;
    },

    on_double_click:function()
    {
        if (this.is_animating()) return;
        if (this.stacked) {
            if(this.unstack()) {
                this.desktop.undo_step();
            }
        } else {
            if(this.restack()) {
                this.desktop.undo_step();
            }
        }
        this.desktop.state_change();

    },

    restack:function()
    {
        var self = this;
        this.stacked = true;
        var count=0;
        $.each(this.desktop.icons, function(i, icon){
            if (icon.visible && icon.stack == self.icon_id && icon !== self)
            {
                count++;
                icon.stack_pos = icon.pos.clone();
                icon.hide_label();
                icon.visible = false;
                var animate_pos = self.get_animate_pos(icon);
                icon.animate_to(animate_pos.x, animate_pos.y, function(){
                    icon.make_invisible();
                });
            }
        });
        return count;
    },

    add_icons:function(icons)
    {
        var self=this;
        $.each(icons, function(i, icon){
            if( icon.visible && icon !== self && icon.type!='stack')
            {
                icon.stack = self.icon_id;
                icon.stack_pos = icon.original_drag_pos.clone();
                icon.visible = false;
                icon.animate_to(self.pos.x, self.pos.y, function(){
                    icon.make_invisible('fast');
                });
            }

        });
    },

    on_drop: function(icon)
    {
        if (this.is_animating()) return;
        if (icon.selected) {
            var icons = this.desktop.get_selected_icons();
        } else {
            var icons = [icon];
        }
        this.new_icons(icons);
    },

    new_icons: function(icons)
    {
        var self = this;
        if (this.stacked)
        {
            this.add_icons(icons)
        }
        else
        {
            $.each(icons, function(i, icon){
                if (icon.type!='stack')
                {
                    icon.unselect();
                    icon.selected = true;
                    icon.stack = self.icon_id;
                    icon.pos = icon.original_drag_pos.clone();
                }
            });
            this.restack();
        }
    },

    contains_icons: function()
    {
        var self=this;
        var has_icons=false;
        $.each(this.desktop.icons, function(i, icon){
            if (icon.stack==self.icon_id)
            {
                has_icons=true;
                return false;
            }
            return true
        });
        return has_icons;
    },

    on_select:function(speed)
    {
        if (this.is_animating()) return;
        if(!this.contains_icons()) {
            this.stacked=true;
        }
    },

    delete_icon: function()
    {
        var self = this;
        this.unstack();
        this.delete_icon_super();
        $.each(this.desktop.icons, function(i, icon){
           if (icon.stack == self.icon_id) icon.stack='';
        });
    }

});


RectSelection= new Class({

    _extends:DesktopItem,

    _init:function(desktop, down_pos)
    {
        var self = this;
        this.desktop = desktop;
        this.down_pos = down_pos.clone();
        this.end_pos = down_pos.clone();

        this.$selection_layer = this.desktop.$desktop.find('.selection-layer:first');
        this.$rect = this.$selection_layer.find('.rect-selection:first');

        this.update_rect();
        this.$rect.show();
    },

    drag:function(mickies) {
        this.end_pos = this.end_pos.plus(mickies);
        this.update_rect();
    },

    on_end_drag:function(e) {
        var self = this;
        var p1 = this.down_pos;
        var p2 = this.end_pos;
        var rect = new Rect(p1, p2);

        this.$rect.hide();
        if (!e.ctrlKey && !e.shiftKey) self.desktop.unselect_all();

        $.each(this.desktop.icons, function(i, icon) {
            icon.$icon_inner.removeClass('pre-selected');
            if (rect.contains_point(icon.pos.plus(icon.handle_offset))) {
                icon.toggle_select();
            }
        })
    },

    update_rect:function() {
        var rect = new Rect(this.down_pos,this.end_pos);
        this.$rect.css(rect.css());

        $.each(this.desktop.icons, function(i, icon){
            if (rect.contains_point(icon.pos.plus(icon.handle_offset))) {
                icon.$icon_inner.addClass('pre-selected');
            } else {
                icon.$icon_inner.removeClass('pre-selected');
            }
        });
    }
});

Guide = new Class({

    _extends: DesktopItem,

    _init: function(desktop, name, mul_w, mul_h, cursor) {
        this.desktop = desktop;
        this.name = name;
        this.pos = new Point(0, 0);
        this.mul = new Point(mul_w, mul_h);
        this.cursor = cursor;
        this.offset = new Point();
        this.offset.x -= 10;
        this.offset.y -= 10;

        var yname = ['top', 'center', 'bottom'][mul_h*2];
        var xname = ['left', 'center', 'right'][mul_w*2];

        this.$guide = $('<div id="guide-{{ name }}" class="guide dir-{{ yname }}-{{ xname }}"> </div>'.f({name:name, xname:xname, yname:yname}));
        //this.$guide.css('cursor', cursor);
        desktop.$guide_layer.append(this.$guide);
        desktop.guides[name] = this;
    },

    show: function() {
        this.$guide.show();
    },

    hide: function() {
        this.$guide.hide();
    },

    update: function(update_bounds) {
        var bounds = update_bounds.clone().grow(10, 10);
        this.pos.set_point( bounds.p1 );
        this.pos.add( bounds.get_dimensions().vector_mul(this.mul) );

        var guide_pos = this.pos.plus(this.offset).restrict();
        this.$guide.css( guide_pos.css() );
    },

    on_start_drag:function() {

    },

    drag:function(drag_mickies) {

        var mickies = drag_mickies.clone();
        if(this.mul.x == 0.5) mickies.x = 0;
        if(this.mul.y == 0.5) mickies.y = 0;

        if (this.mul.x == 0) {
            this.desktop.drag_bounds.p1.x += mickies.x;
        } else {
            this.desktop.drag_bounds.p2.x += mickies.x;
        }

        if (this.mul.y == 0) {
            this.desktop.drag_bounds.p1.y += mickies.y;
        } else {
            this.desktop.drag_bounds.p2.y += mickies.y;
        }

        this.desktop.drag_bounds.update();
        var bounds = this.desktop.fit_selection_to_bounds(this.desktop.drag_bounds);

        this.desktop.update_guides(bounds);
        this.$guide.addClass('active');
    },

    on_end_drag: function(e) {

        var bounds = this.desktop.fit_selection_to_bounds(this.desktop.drag_bounds, true);
        this.desktop.update_guides(bounds);
        this.$guide.removeClass('active');
    }

});


Desktop = new Class({

    _init: function(desktop_selector)
    {
        var self = this;

        this.username = $('#username').val();
        this.name = $('#desktop_slug').val();

        this.api_url = "/api/";

        this.$desktop = $('body');

        this.guides = {};
        this.icons = {};
        this.icon_index = 1;

        this.mouse_down_pos = new Point(0, 0);
        this.last_mouse_pos = new Point(0, 0);
        this.drag_object = null;
        this.drag_window = false;

        this.rect_selection = null;

        this.icon_physical_size = new Point(110, 80);
        this.icon_size = new Point(120, 80);

        this.undo_stack = [];
        this.undo_position = -1;

        this.active_dialog = '';


        this.$top = $(document);

        this.$body = $('body');
        this.$icon_layer = $('.icon-layer:first');
        this.$guide_layer = $('.guide-layer:first');

        this.undo_step_level = 0;
        this.save_position = 0;
        this.update_position = 0;

        var desktop = this;

        $('.options-link').click(function(){
            $('.options').toggle();
        });

        function onmousemove(e)
        {
            if (desktop.drag_object !== null)
            {
                e.stopPropagation();
                var new_point = new Point(e.pageX, e.pageY);
                var mickies = new_point.minus( desktop.last_mouse_pos );
                desktop.drag_object.drag(mickies);
                desktop.last_mouse_pos = new_point.clone();
                return false;
            }
            return true;
        }
        this.$top.mousemove(onmousemove);


        function onmouseup(e)
        {
            var click_time = clock() - desktop.mouse_down_time;
            var up_pos = new Point(e.pageX, e.pageY);

            var double_click = false;
            var double_click_object = null;

            if (desktop.drag_object)
            {
                if (desktop.mouse_down_pos.get_distance(up_pos) < 3.0 && click_time < 0.5)
                {
                    if (!e.ctrlKey && !e.shiftKey) {
                        desktop.unselect_all(desktop.drag_object);
                        $('.menu').fadeOut('fast');
                    }
                    var t = clock();
                    if (desktop.drag_object.last_click_time && t-desktop.drag_object.last_click_time < 0.5)
                    {
                        desktop.drag_object.last_click_time = clock();
                        double_click_object = desktop.drag_object;
                        double_click = true;
                    }
                    else
                    {
                        desktop.drag_object.last_click_time = clock();
                        desktop.drag_object.on_click(e);
                    }
                }
            }

            desktop.end_drag(e);

            if (double_click && double_click_object) {
                double_click_object.on_double_click();
            }

            desktop.mouse_down_time = null;
            desktop.drag_object = null;

            desktop.state_change();

            return false;
        }
        this.$top.mouseup(onmouseup);
        //$(document).mouseup(onmouseup);

        function onwindowresize(e)
        {
            if(self.active_dialog) {
                dialogs[self.active_dialog].$dialog.center(true);
            };
        }
        $(window).resize(onwindowresize);

        function onmousedown(e)
        {
            if(e.target.tagName != 'A' && e.target.tagName!= 'UL')
            {
                $('.menu').fadeOut('fast');
                //e.stopPropagation();
            }
            if(e.target.tagName == 'HTML')
            {
                var mouse_point = new Point(e.clientX, e.clientY);

                var $edgemarker = $('#edgemarker')[0];
                var edge_rect = $edgemarker.getBoundingClientRect();
                if (mouse_point.x > edge_rect.left ||
                    mouse_point.y > edge_rect.top) return true;

                e.stopPropagation();
                desktop.mouse_down_time = clock();
                var down_pos = new Point(e.pageX, e.pageY);
                desktop.mouse_down_pos = down_pos.clone();
                desktop.last_mouse_pos = down_pos.clone();
                desktop.start_drag_desktop(down_pos);
                desktop.drag_window = true;
                return false;
            }
            return true;
        }
        this.$top.mousedown(onmousedown);

        $buttons_layer = $('.buttons-layer:first');
        $buttons_layer.find('.button-new').click(function(){self.show_dialog('new-icon');});
        $buttons_layer.find('.button-new-stack').click(function(){self.stack();});
        $buttons_layer.find('.button-info').click(function(){self.show_dialog('edit-icon');});
        $buttons_layer.find('.button-arrange-square').click(function(){self.arrange_grid(true);});
        $buttons_layer.find('.button-arrange-grid').click(function(){self.arrange_grid(false);});
        $buttons_layer.find('.button-arrange-circle').click(function(){self.arrange_circle();});
        $buttons_layer.find('.button-arrange-horizontal').click(function(){self.arrange_horizontal();});
        $buttons_layer.find('.button-arrange-vertical').click(function(){self.arrange_vertical();});
        $buttons_layer.find('.button-undo').click(function(){self.undo();});
        $buttons_layer.find('.button-redo').click(function(){self.redo();});
        $buttons_layer.find('.button-delete').click(function(){self.delete_icon();});
        $buttons_layer.find('.button-create-stack').click(function(){self.instack();});
        $buttons_layer.find('.button-unstack').click(function(){self.outstack();});

        $('.save-desktop:first').click(function(){

            if (NEW_DESKTOP) {
                var definition = JSON.stringify(desktop.get_state());
                desktop.api('set_new_desktop',
                            {definition:definition});
                show_signup = function() {
                    desktop.show_dialog('signup');
                }
                popup('new_desktop', {label:'Create a free account', callback:function(){setTimeout(show_signup, 100);return true;}},
                                        {label:'Cancel'});
                //desktop.show_dialog('signup');
                return false;
            }
            if (self.is_saved() || confirm('Save changes to this desktop?'))
            {
                //if (!self.is_saved()) {
                //    self.shade(true);
                //}
                self.finish_editing();
            }
            return false;
        });

        $('.discard-desktop:first').click(function(){
            if (self.save_position == self.update_position || confirm('Discard your changes to this desktop?'))
            {
                var view_url = $('#view_url').val();
                allow_exit = true;
                window.location = view_url;
            }
            return false;
        });

        $('.options-menu:first').click(function(){

           return show_menu('options');

        });

        $('.refresh-icons').click(function(){

            var desktop = self;
            function do_refresh()
            {
                var urls = '';
                $.each(desktop.icons, function(name, icon){
                    if (icon.url) {
                        urls += icon.url+'|';
                    }
                });

                self.api('refresh_icons', {urls:urls}, function(remote){
                    var favicons = remote.response.favicons;
                    var count = 0;
                    desktop.unselect_all();
                    $.each(desktop.icons, function(name, icon){
                        if (favicons[icon.url])
                        {
                            var favicon = favicons[icon.url];

                            if (icon.favicon_img_url_template != favicon.favicon_img_url_template)
                            {
                                icon.favicon_img_url_template = favicon.favicon_img_url_template;
                                icon.favicon_sizes = favicon.favicon_sizes.slice();
                                icon.has_favicon = true;
                                icon.use_favicon = true;
                                icon.change_size(0, true);
                                icon.select();
                                count++;
                            }
                        }
                    });
                    if (!count) {
                        desktop_alert("Refresh icons", "No new icons to update.")
                    }
                    else if (count==1) {
                        desktop.undo_step();
                        desktop_alert("Refresh icons", "1 icon was updated.");
                    } else {
                        desktop.undo_step();
                        desktop_alert("Refresh icons", "{{ count }} icons were updated.".f({count:count}));
                    }

                });
                return true;
            }


            popup('alert', {label:"Refresh icons", callback:do_refresh}, {}, {title:"Refresh Icons", message:"This will replace the icons with newer versions (if available)"});

            //desktop_alert("This will replace the icons with newer versions (if available)");
            return false;

        });

        allow_exit = false;
        window.onbeforeunload = function(e) {

            if (allow_exit) return undefined;
            if (self.save_position != self.update_position) {
                return "You have un-saved changes to your desktop.";
            }
            return undefined;
        }

    },

    is_blank: function()
    {
        for (var icon in this.icons) {
            return false;
        }
        return true;
    },

    api: function(method, data, callback)
    {
        api_call_id++;
        var method_url = this.api_url + method + "/";
        data['call_id'] = api_call_id;
        $.post(method_url, data, callback, 'json');
        return api_call_id;
    },

    finish_editing: function()
    {
        var self=this;
        this.save(function(){
            var view_url = $('#view_url').val();
            window.location = view_url;
        });
    },

    save_desktop: function(success_callback)
    {
        var self=this;
        this.save(success_callback || function(){
            alert("TODO: Saved!");
        });
    },

    discard_changes: function()
    {
        var view_url = $('#view_url').val();
        window.location = view_url;
    },

    state_change: function()
    {
        if (check_state_timeout != null) {
            window.clearTimeout(check_state_timeout);
        }
        var self = this;
        function handle_state_change() {
            self.check_selected();
            self.place_guides();
        }
        check_state_timeout = setTimeout(handle_state_change, 50);
    },

    raise_button: function(button, raise)
    {
        var anim_options = {duration:250, easing:'swing', queue:false};
        if (raise) {
            $('.'+button).animate({top:'-68px'}, anim_options);
        } else {
            $('.'+button).animate({top:'0px'}, anim_options);
        }
    },

    get_selected_stack: function()
    {
        for(var icon_name in this.icons)
        {
            var icon = this.icons[icon_name];
            if (icon.selected && icon.type=="stack")
            {
                return icon;
            }
        }
        return null;
    },

    check_selected: function()
    {
        if (this.active_dialog)
        {
            var self=this;
            var buttons = ['new', 'delete', 'new-stack', 'info', 'create-stack', 'unstack', 'undo', 'redo',
                           'arrange-horizontal', 'arrange-vertical', 'arrange-square', 'arrange-grid', 'arrange-circle'];
            $.each(buttons, function(i, bname) {
                self.raise_button("button-"+bname, false);
            })
            return;

        }
        var selected_count = this.count_selected();

        this.raise_button('button-new', true);
        this.raise_button('button-delete', selected_count);

        this.raise_button('button-info', selected_count==1)
        this.raise_button('button-new-stack', this.any_selected('icon'));

        var stacks_selected = this.any_stacks_selected();

        var selected_stack = this.get_selected_stack();
        if (selected_stack && !selected_stack.contains_icons())
        {
            this.raise_button('button-create-stack', false);
            this.raise_button('button-unstack', false);
        } else {
            this.raise_button('button-create-stack', stacks_selected && !selected_stack.stacked);
            this.raise_button('button-unstack', stacks_selected && selected_stack.stacked);
        }

        this.raise_button('button-undo', this.undo_position > 0);
        this.raise_button('button-redo', this.undo_position < this.undo_stack.length-1);

        this.raise_button('button-arrange-horizontal', selected_count > 1);
        this.raise_button('button-arrange-vertical', selected_count > 1);
        this.raise_button('button-arrange-square', selected_count > 2);
        this.raise_button('button-arrange-grid', selected_count > 2);
        this.raise_button('button-arrange-circle', selected_count > 2);
    },

    start_drag: function(down_pos, object)
    {
        this.mouse_down_pos = down_pos.clone();
        this.last_mouse_pos = down_pos.clone();
        this.drag_object = object;
        this.mouse_down_time = clock();
        if (this.drag_object) this.drag_object.on_start_drag();
    },

    end_drag: function(event)
    {
        if (this.drag_object) this.drag_object.on_end_drag(event);
        this.drag_window = false;
        this.mouse_down_pos = null;
        this.drag_object = null;
    },

    start_drag_desktop: function(down_pos)
    {
        this.mouse_down_pos = down_pos.clone();
        this.last_mouse_pos = down_pos.clone();
        this.rect_selection = new RectSelection(this, down_pos);
        this.drag_object = this.rect_selection;
    },

    rebind: function()
    {
        var self = this;
        this.$icon_layer.find('.handle').unbind().mousedown(function(e){

            var $this = $(this);
            var name = $this.attr('id').remainder('-');
            var icon = self.icons[name];

            self.start_drag(new Point(e.pageX, e.pageY), icon);
            return false;
        });
        this.$icon_layer.find('.icon-label').unbind().mousedown(function(e){
            var $this = $(this).parent();
            var name = $this.attr('id').remainder('-');
            var icon = self.icons[name];
            self.start_drag(new Point(e.pageX, e.pageY), icon);
            return false;
        });
        this.$icon_layer.find('.size-change').unbind('click').click(function(e){
            $this = $(this);
            var id = $this.attr('id');
            var tokens = id.split('_');
            var dir = 0;
            if (tokens[0]=='up') {
                dir = +1;
            } else {
                dir = -1;
            }
            var icon = self.icons[tokens[1]];
            var selected_icons = self.get_selected_icons();
            if (false && icon.selected) {
                $(selected_icons).each(function(icon_name, icon){
                    icon.change_size(dir);
                });
                self.undo_step();
            } else {
                icon.change_size(dir);
                self.undo_step();
            }

        });
        this.state_change();
    },

    bind_guides: function()
    {
        var self = this;
        this.$guide_layer.find('.guide').unbind().mousedown(function(e) {

            var $this = $(this);
            var name = $this.attr('id').split('-')[1];
            var guide = self.guides[name];

            self.start_drag(new Point(e.pageX, e.pageY), guide);
            return false;
        });
    },

    new_icon_id: function(prefix)
    {
        var icon_key = prefix + '-' + (++this.icon_index);
        if(this.icons[icon_key])
        {
            var last_key = 1;
            $.each(this.icons, function(i, icon) {
                last_key = Math.max( last_key, parseInt( icon.icon_id.split('-')[1] ) );
            });
            return prefix + '-' + (++last_key);
        }
        return icon_key;
    },

    new_icon: function(new_icon, skip_set_state)
    {
        var prefix = 'icon';
        var cls = Icon;
        if (new_icon.type == 'stack') {
            cls = Stack;
        }

        var icon_identifier = new_icon.icon_id;
        if (!icon_identifier) icon_identifier = this.new_icon_id(prefix);
        new_icon.icon_id = icon_identifier;

        var icon_sizes = get_icon_sizes(new_icon).slice();
        var display_size=icon_sizes[0];
        for (var s=0; s<icon_sizes.length; s++) {
            if (icon_sizes[s]==new_icon.icon_size) {
                display_size = icon_sizes[s];
            }
            display_size = icon_sizes[s];
            if (icon_sizes[s]>=new_icon.icon_size) {
                break;
            }
        }

        var img_url = get_img_template(new_icon).replace(/\[SIZE\]/g, display_size);

        //img_url = MEDIA_URL + img_url;
        img_url = pathjoin([MEDIA_URL, img_url]);

        var icon_width = Math.max(new_icon.icon_size * 1.5, 96);


        var td = {  icon_id:icon_identifier,
                    img_url:img_url,
                    icon_size:display_size,
                    icon_width:icon_width,
                    name:new_icon.name};

        for(var k in new_icon) {
            td[k] = new_icon[k];
        }


        var html = icon_template.f(td);


        this.$icon_layer.append(html);
        var $icon = $('.'+icon_identifier);

        var pos = new_icon.pos;
        if (!pos) pos = new Point();

        var icon = new cls(this, icon_identifier, '', $icon, img_url);
        if (pos) {
            icon.move_to(pos.x, pos.y);
        }

        if (!skip_set_state) {
            icon.set_state(new_icon);
        }
        icon.update();

        if (icon.search_url) {
            icon.$icon.find('.search-box').show();
        }

        if(new_icon.visible) {
            icon.make_visible();
        }

        var width_overflow = Math.min(new_icon.icon_size * 0.5, 32);
        var icon_width = Math.max(new_icon.icon_size + width_overflow, 96);
        $icon.css({width:icon_width});

        this.icons[icon_identifier] = icon;
        this.rebind();
        return icon;
    },

    add_icon: function(x, y, img_url_template, no_show, cls, prefix, options)
    {
        var p = new Point(x, y);
        cls = cls || Icon;
        prefix = prefix || 'icon';

        var icon_identifier = this.new_icon_id(prefix);

        var icon_width = Math.max(DEFAULT_ICON_SIZE * 1.5, 96);

        var img_url = img_url_template.replace(/\[SIZE\]/g, DEFAULT_ICON_SIZE);

        //img_url = MEDIA_URL + img_url;
        img_url = pathjoin([MEDIA_URL, img_url]);

        var td = {  icon_id:icon_identifier,
                    img_url:img_url,
                    icon_width:icon_width,
                    icon_size:DEFAULT_ICON_SIZE };
        var html = icon_template.f(td);

        this.$icon_layer.append(html);

        var $icon = $('.'+icon_identifier);
        $icon.css( p.css() )

        var icon = new cls(this, icon_identifier, '', $icon, img_url);
        icon.icon_size = DEFAULT_ICON_SIZE;
        icon.move_to(p.x, p.y);
        icon.img_url_template = img_url_template;
        icon.update();

        if(!no_show) icon.make_visible();

        this.icons[icon_identifier] = icon;
        this.rebind();

        return icon;
    },

    make_stack: function(x, y)
    {
        var new_stack = this.add_icon(x, y, DEFAULT_STACK_URL, true, Stack, 'stack');
        new_stack.icon_sizes = eval($('#stack_icon_sizes').val());
        new_stack.icon_key = $('#stack_icon_key').val();
        new_stack.set_name('New Stack');
        return new_stack;
    },

    stack: function()
    {
        var icons = [];
        $.each(this.get_selected_icons(), function(i, icon){
            if (icon.type=="icon") icons.push(icon);
        });

        if (!icons.length) return false;

        var center = this.get_icon_centroid();
        var stack = this.make_stack();
        stack.visible = true;
        stack.move_to(center.x, center.y);

        stack.$icon.fadeIn();
        stack.build(icons);
        this.undo_step();
        this.state_change();
        return true;
    },


    unstack: function()
    {
        var count=0;
        $.each(this.get_selected_icons(), function(i, icon){
            if (icon.type == 'stack') {
                if (icon.unstack()) count++;
            }
        });
        if(count) this.undo_step();

        this.state_change();
    },

    instack: function()
    {
        var count = 0;
        $.each(this.get_selected_icons(), function(i, icon){
            if (icon.type=="stack") {
                if(icon.restack()) count++;
            }
        });
        if (count) this.undo_step();

        this.state_change();
    },

    outstack: function()
    {
        var count = 0;
        $.each(this.get_selected_icons(), function(i, icon){
            if (icon.type=="stack") {
                if(icon.unstack()) count++;
            }
        });
        if (count) this.undo_step();

        this.state_change();
    },

    delete_icon: function()
    {
        var self = this;
        $.each(this.get_selected_icons(), function(i, icon) {
            delete self.icons[icon.icon_id];
            icon.delete_icon();
        });
        this.undo_step();
        this.state_change();
    },

    unselect_all: function(except_object)
    {
        $.each(this.icons, function(i, icon){
            if (icon !== except_object) icon.unselect();
        });
        this.state_change();
    },

    count_selected: function()
    {
        var count=0;
        $.each(this.icons, function(i, icon){
            if (icon.selected && icon.visible) count++;
        });
        return count;
    },

    any_selected: function(icon_type)
    {
        if (icon_type === undefined)
        {
            for(var icon_id in this.icons) {
                var icon = this.icons[icon_id];
                if (icon.selected && icon.visible) return true;
            }
        } else {
            for(var icon_id in this.icons) {
                var icon = this.icons[icon_id];
                if (icon.selected && icon.visible && icon.type == icon_type) return true;
            }
        }
        return false;
    },

    any_stacks_selected: function()
    {
        for(var icon_id in this.icons) {
            var icon = this.icons[icon_id];
            if (icon.selected && icon.visible && icon.type=="stack") return true;
        }
        return false;
    },

    any_icons_selected: function()
    {
        for(var icon_id in this.icons) {
            var icon = this.icons[icon_id];
            if (icon.selected && icon.visible && icon.type=='icon') return true;
        }
        return false;
    },

    any_two_selected: function()
    {
        var count = 0;
        for(var icon_id in this.icons) {
            var icon = this.icons[icon_id];
            if (icon.selected && icon.visible) count++;
            if (count==2) return true;
        }
        return false;
    },

    get_max_icon_size: function(icons)
    {
        if (icons == undefined) {
            icons = this.get_selected_icons();
        }
        max_size = new Point(0, 0);
        $.each(icons, function(i, icon){
            max_size.max(icon.get_size());
        });
        return max_size;
    },

    get_total_radius: function(icons)
    {
        if (icons == undefined) {
            icons = this.get_selected_icons();
        }
        total_radius = 0.0;
        $.each(icons, function(i, icon) {
            var size = icon.get_size();
            var w = size.x;
            var h = size.y;
            total_radius += Math.sqrt(w*w + h*h);
        });
        return total_radius;
    },

    arrange_horizontal: function()
    {
        var bounds = this.get_selection_handle_bound();
        var center = bounds.get_center();
        var num_icons = this.count_selected();
        var max_size = this.get_max_icon_size();
        var w = max_size.x;
        var h = max_size.y;

        if (num_icons <= 1) return false;
        var positions = [];
        var start_pos = new Point(center.x - ((num_icons-1) * w) / 2, center.y);
        for (var x = 0; x < num_icons; x++) {
            positions.push(new Point(start_pos.x + x*w, start_pos.y));
        }
        this.arrange(positions);
        return true;
    },

    arrange_vertical: function()
    {
        var bounds = this.get_selection_handle_bound();
        var center = bounds.get_center();
        var num_icons = this.count_selected();

        var max_size = this.get_max_icon_size();
        var w = max_size.x;
        var h = max_size.y;

        if (num_icons <= 1) return false;
        var positions = [];
        var start_pos = new Point(center.x, center.y - ((num_icons-1) * h) / 2);
        for (var y = 0; y < num_icons; y++) {
            positions.push(new Point(start_pos.x, start_pos.y + y*h))
        }
        this.arrange(positions);
        return true;
    },


    arrange_grid: function(square, instant, fit_to_window)
    {
        var icons = this.get_selected_icons();
        var num_icons = this.count_selected();
        if (num_icons <= 1) return false;

        var center = this.get_icon_center();
        if (fit_to_window)
        {
            var w = $window.width();
            var h = $window.height();
            var bounds = new Rect(new Point(32, 32), new Point(w-128, h-128));

        } else {
            var bounds = this.get_selection_handle_bound();
        }

        var size = this.get_max_icon_size();

        if (square) {
            var a = Math.ceil(Math.sqrt(num_icons));
        } else {
            var a = Math.round(bounds.w / size.x)+1;
        }
        var grid_size = new Point(a, Math.ceil(num_icons / a));
        var start_pos = bounds.p1.clone();

        var positions = [];
        for (var y=0; y < grid_size.y; y++) {
            for (var x=0; x < grid_size.x; x++) {
                var pos = new Point(start_pos.x + x*size.x, start_pos.y + y*size.y);
                positions.push(pos);
                if (positions.length >= icons.length) break;
            }
            if (positions.length >= icons.length) break;
        }

        this.arrange(positions, instant);
        return true;
    },

    center_icons: function()
    {
        var $window = $(window);
        var window_size = new Point($window.width(), $window.height());
        var bounds = this.get_selection_points_bound();
        var selection_size = bounds.get_dimensions();
        var adjust_center = window_size.minus(selection_size).scalar_div(2).minus(bounds.p1);

        $.each(this.get_selected_icons(), function(i, icon){
           icon.move(adjust_center);
        });
    },

    offset_icons: function(offset)
    {
        $.each(this.get_selected_icons(), function(i, icon){
           icon.move(offset);
        });
    },

    arrange_circle: function()
    {
        var icons = this.get_selected_icons();
        if ( icons.length <= 2 ) return false;
        var bounds = this.get_selection_handle_bound();
        var center = bounds.get_center();
        var positions = [];
        var total_radius = this.get_total_radius();
        var segment_radius = total_radius / icons.length;
        var segment_angle = (2*Math.PI) / icons.length;
        var d = (segment_radius * icons.length-1) / Math.PI;
        var r = d / 2;

        var max_size = this.get_max_icon_size();
        var w = max_size.x;
        var h = max_size.y;

        var hw = w / 2;
        var hh = h / 2;
        //for (var a = 0; a < Math.PI*2; a += segment_angle)
        for (var i = 0; i<icons.length; i++)
        {
            var a = i * segment_angle;
            var aa = a + Math.PI;
            var x = Math.sin(aa) * r;
            var y = Math.cos(aa) * r;
            positions.push( new Point(center.x + x, center.y + y) );
        }
        this.arrange(positions);
        return true;
    },

    arrange_explode: function(square)
    {
        var icons = this.get_selected_icons();
        if ( icons.length < 2 ) return false;
        var bounds = this.get_selection_bound();
        var center = bounds.get_center();
        var positions = [];
        var segment_radius = 100;
        var segment_angle = (2*Math.PI) / icons.length;
        var d = (segment_radius * icons.length) / Math.PI;
        var r = d / 2;
        var hw = this.icon_size.x / 2;
        var hh = this.icon_size.y / 2;
        for (var a = 0; a < Math.PI*2; a += segment_angle)
        {
            var r = 50 + Math.random() * (r);
            var aa = Math.random() * 2. *  Math.PI;
            var x = Math.sin(aa) * r;
            var y = Math.cos(aa) * r;
            positions.push( new Point(center.x + x - hw, center.y + y - hh) );
        }
        this.arrange(positions);
        return true;
    },

    restrict_positions: function(positions)
    {
        var edge = new Point();
        $.each(positions, function(i, pos){
            if (pos.x < 0) {
                edge.x = Math.min(edge.x, pos.x);
            }
            if (pos.y < 0) {
                edge.y = Math.min(edge.y, pos.y);
            }
        });

        var new_positions = [];
        $.each(positions, function(i, pos) {
            new_positions.push(pos.minus(edge).round());
        });
        return new_positions;
    },

    arrange: function(positions, instant)
    {
        var icons = this.get_selected_icons();

        var total_d = 0;
        var move_icons = [];

        positions = positions.slice();
        var center = new Point();
        for (var i=0; i<positions.length; i++){
            center.add(positions[i]);
        }
        center = center.scalar_div(positions.length);
        function cmp_distance(p1, p2)
        {
            var d1 = p1.get_distance(center);
            var d2 = p2.get_distance(center);
            return d1-d2;
        }
        positions = positions.sort(cmp_distance);

        $.each(positions, function(i, spot_pos) {

            var closest_i = 0;
            var closest_d = 100000;

            $.each(icons, function(ii, icon) {
                var icon_pos = icon.pos.plus(icon.handle_offset);
                var d = icon_pos.get_distance(spot_pos);
                if (d < closest_d) {
                    closest_i = ii;
                    closest_d = d;
                }
            });
            total_d += closest_d;

            icon = icons.splice(closest_i, 1)[0];
            spot_pos.subtract(icon.handle_offset);
            move_icons.push([icon, spot_pos.clone()]);

            return !!(icons.length);
        });

        var edge = new Point();
        $.each(move_icons, function(i, move_icon){
           var pos = move_icon[1];
            if (pos.x < 0) {
                edge.x = Math.min(edge.x, pos.x);
            }
            if (pos.y < 0) {
                edge.y = Math.min(edge.y, pos.y);
            }
        });

        $.each(move_icons, function(i, move_icon){
            var icon = move_icon[0];
            var move_pos = move_icon[1];
            move_pos.subtract(edge).round();
            if(instant) {
                icon.move_to(move_pos.x, move_pos.y);
            } else {
                icon.animate_to(move_pos.x, move_pos.y);
            }
        });

        if (total_d) this.undo_step(); // Only save a step if there has been total movement
    },

    get_selected_icons: function()
    {
        var icons = [];
        $.each(this.icons, function(i, icon) {
            if (icon.selected && icon.visible) icons.push(icon);
        })
        return icons;
    },

    get_icon_center: function()
    {
        var count = 0;
        var center = new Point();
        $.each(this.icons, function(i, icon){
            if (icon.selected && icon.visible)
            {
                center.add(icon.pos.plus(icon.handle_offset));
                count++;
            }
        })
        return center.scalar_div(count);
    },


    get_icon_centroid: function()
    {
        var count = 0;
        var center = new Point();
        $.each(this.icons, function(i, icon){
            if (icon.selected && icon.visible)
            {
                center.add(icon.pos);
                count++;
            }
        })
        return center.scalar_div(count);
    },

    get_selection_handle_bound: function()
    {
        var self = this;
        var min = new Point(10000, 10000);
        var max = new Point(-10000, -10000);
        $.each(this.icons, function(i, icon) {
            if (icon.selected && icon.visible) {
                var p = icon.pos.plus(icon.handle_offset);
                min.min(p);
                max.max(p)
            }
        });
        return new Rect(min, max);

    },

    get_selection_bound: function()
    {
        var self = this;
        var min = new Point(10000, 10000);
        var max = new Point(-10000, -10000);
        $.each(this.icons, function(i, icon) {
            if (icon.selected && icon.visible) {

                var p1 = icon.pos.clone();
                var p2 = p1.plus(icon.get_size());
                min.min(p1).min(p2);
                max.max(p1).max(p2);
            }
        });
        return new Rect(min, max);
    },

    get_selection_points_bound: function()
    {
        var min = new Point(10000, 10000);
        var max = new Point(-10000, -10000);
        $.each(this.icons, function(i, icon) {
            if (icon.selected && icon.visible) {
                var p = icon.pos.plus(icon.handle_offset);
                min.min(p);
                max.max(p);
            }
        });
        return new Rect(min, max);
    },

    get_state: function()
    {
        var self = this;
        var state = {};
        state['icon_size'] = this.icon_size;

        state.icons = [];
        $('.icon-layer .icon').each(function(){
            var name = $(this).attr('id');
            var icon = self.icons[name];
            if (icon) {
                if (icon.stack) {
                    if(!self.icons[icon.stack].stacked) {
                        icon.stack_pos.set_point(icon.pos);
                    }
                }
                state.icons.push(icon.get_state());
            }
        });
        state.desktop_name = this.name;
        return state;
    },

    set_state: function(state)
    {
        var self = this;
        if(!('icons' in this)) {
            this.icons = {};
        }

        this.name = state.desktop_name;

        var icons_remaining = {};
        //for (var icon_name in this.icons) {
        $.each(this.icons, function(icon_name, icon){
            icons_remaining[icon_name]=true;
        });


        $.each(state.icons, function(i, icon_state_restore) {

            var icon_name = icon_state_restore.icon_id;

            if (icon_name in icons_remaining) {
                var icon = self.icons[icon_name];
                icons_remaining[icon_name] = false;
                if (icon.issame(icon_state_restore)) {
                    return true;
                }

                icon.set_state(icon_state_restore);
                icon.move_to(icon_state_restore.pos.x, icon_state_restore.pos.y);
                icon.change_size(0, true);
                if (!icon.selected && icon_state_restore.selected)
                {
                    icon.move_to_top();
                }
                icon.setselect(icon_state_restore.selected);
                if (icon.visible) {
                    icon.make_visible();
                    icon.show_label();
                } else {
                    icon.make_invisible();
                }

            } else {

                var icon_state = {};
                $.each(icon_state_restore, function(k, v){
                    icon_state[k] = icon_state_restore[k];
                });
                /*for (k in icon_state_restore) {
                    icon_state[k] = icon_state_restore[k];
                }*/
                icons_remaining[icon_name] = false;
                var icon = self.new_icon(icon_state);
                icon.change_size(0);
            }
            icon.update();
            return true;
        });


        $.each(icons_remaining, function(icon_name, remaining){
            if (remaining && icon_name in self.icons) {
                self.icons[icon_name].$icon.remove();
                delete self.icons[icon_name];
            }
        });


        this.state_change();
    },

    begin_undo_step: function()
    {
        this.undo_step_level++;
    },

    end_undo_step: function()
    {
        if(!--this.undo_step_level) {
            this.undo_step();
        }
    },

    undo_step: function()
    {
        if (this.undo_step_level) {
            return;
        }
        var state = this.get_state();
        if (this.undo_stack.length)
        {
            var num_remove = this.undo_position - this.undo_stack.length-1;
            this.undo_stack = this.undo_stack.splice(0, this.undo_position+1);
        }
        this.undo_stack.push(state);
        this.undo_position++;

        this.update_position++;
    },

    clear_undo: function() {
        this.undo_stack = [];
        this.undo_position = -1;
    },

    undo: function()
    {
        if (!this.undo_position) return false;
        this.undo_position--;
        var state = this.undo_stack[this.undo_position];
        this.set_state(state);
        this.state_change();
        return true;
    },

    redo: function()
    {
        if (this.undo_position == this.undo_stack.length-1) return false;
        this.undo_position++;
        var state = this.undo_stack[this.undo_position];
        this.set_state(state);
        this.state_change();
        return true;
    },

    place_guides: function()
    {
        this.guides = {};
        if (this.count_selected() < 2)
        {
            this.$guide_layer.empty();
            return;
        }
        if (!this.guides.length)
        {
            this.$guide_layer.empty();

            var tl_guide = new Guide(this, 'tl', 0, 0, 'nw-resize');
            var tr_guide = new Guide(this, 'tr', 1, 0, 'ne-resize');
            var bl_guide = new Guide(this, 'bl', 0, 1, 'sw-resize');
            var br_guide = new Guide(this, 'br', 1, 1, 'se-resize');

            var t_guide = new Guide(this, 't', 0.5, 0, 'n-resize');
            var l_guide = new Guide(this, 'l', 0,   0.5, 'w-resize');
            var b_guide = new Guide(this, 'b', 0.5, 1, 's-resize');
            var r_guide = new Guide(this, 'r', 1, 0.5, 'e-resize');

            this.bind_guides();
        }

        this.update_guides();
        if (!this.guides_hidden)
        {
            $.each(this.guides, function(i, guide){
                guide.show();
            });
        }

        var bounds = this.get_selection_points_bound();
        this.original_bounds = bounds.clone();
        this.drag_bounds = bounds.clone();
    },

    update_guides: function(ubounds)
    {
        var self = this;

        var bounds = ubounds || self.get_selection_bound();
        $.each(self.guides, function(i, guide){
            guide.update(bounds);
        });

    },

    hide_guides: function() {
        this.guides_hidden = true;
        $.each(this.guides, function(i, guide){
            guide.hide();
        });
    },

    show_guides: function() {
        this.guides_hidden = false;
    },

    fit_selection_to_bounds: function(new_bounds, fix) {

        var bounds = this.original_bounds;
        var old_dimensions = bounds.get_dimensions();
        var new_dimensions = new_bounds.get_dimensions();

        var min_pos = new Point(1000000, 100000);
        var max_pos = new Point();

        $.each(this.get_selected_icons(), function(i, icon) {
            var pos = icon.pos.clone().plus(icon.handle_offset);
            var pos_ratio = pos.minus( bounds.p1 ).vector_div(old_dimensions);
            var new_pos = new_bounds.p1.plus( pos_ratio.vector_mul(new_dimensions) ).minus(icon.handle_offset).restrict();
            if (fix) {
                icon.move_to(new_pos.x, new_pos.y);
            } else {
                icon.move_visual_to(new_pos.x, new_pos.y);
            }
            icon_extent = new_pos.plus( icon.get_size() );
            min_pos.min(new_pos).min(icon_extent);
            max_pos.max(new_pos).max(icon_extent);
        });
        icon_bounds = new Rect(min_pos, max_pos);
        if (fix) this.undo_step();
        return icon_bounds;
    },

    get_hover_icon: function(x, y)
    {
        var self = this;
        var p = new Point(x, y);
        var hover_icon=null;
        $.each(this.icons, function(i, icon) {

            if (icon.visible && icon !== self.drag_object && icon.get_handle_rect().contains_point(p))
            {
                hover_icon = icon;
                return false;
            }
            return true;
        });
        return hover_icon;
    },

    highlight_hover: function()
    {

        var p = this.drag_object.pos.plus(this.drag_object.handle_offset)
        var hover_icon = this.get_hover_icon(p.x, p.y);

        if (hover_icon !== this.last_hover_icon) {
            if (hover_icon) hover_icon.on_hover_icon();
        }
        this.last_hover_icon = hover_icon;

        this.$icon_layer.find('.icon').removeClass('hover-over');
        if (hover_icon) {
            hover_icon.$icon.addClass('hover-over');
        }
    },

    remove_hover_highlights: function()
    {
        this.$icon_layer.find('.icon').removeClass('hover-over');
    },

    is_saved: function()
    {
        var self = this;
        return self.save_position == self.update_position;
    },

    save: function(callback)
    {
        var self = this;
        var state = this.get_state();
        var state_json = JSON.stringify(state);
        function wrap_callback(remote)
        {
            if (remote.response.result=='fail') {
                popup_alert("Save Desktop", remote.response.msg);
                return null;
            }
            else {
                self.save_position = self.update_position;
                if (callback) {
                    return callback()
                }
                return true
            }
        }
        this.api('set_desktop',
                 {definition:state_json, username:this.username || '', desktop:this.name},
                 wrap_callback);
    },

    load: function()
    {
        var self=this;
        this.api('get_desktop', {username:this.username, desktop:this.name}, function(remote) {
            var state = eval('['+remote.response.definition+']')[0];
            if (state) {
                self.clear_undo();
                self.set_state(state);
                self.undo_step();
            }
        });
    },

    shade: function(shade_in)
    {
        if(shade_in) {
            $('.dialog-shade').fadeIn('fast');
        } else {
            $('.dialog-shade').fadeOut('fast');
        }
    },

    show_dialog: function(dialog_name, no_shade)
    {
        this.active_dialog=dialog_name;
        this.check_selected();
        if (!no_shade)
        {
            this.shade(true);
        }
        dialogs[dialog_name].show(this);
    },

    on_new_icons: function(icons, top_left)
    {
        var self = this;
        var added_icons = [];
        self.unselect_all();
        $.each(icons, function(i, new_icon){
            var icon = self.new_icon(new_icon);
            icon.name = new_icon.name;
            icon.select();
            icon.move_to_top();
        });
        self.begin_undo_step();
        if (!top_left)
        {
            self.arrange_grid(true, true);
            self.center_icons();
        } else {
            self.arrange_grid(false, true, true);
            self.offset_icons(new Point(32, 32))
        }
        self.end_undo_step();
    }

});


Dialog = new Class({


   _init: function(name)
   {
        var self=this;
        self.$dialog = $('#'+self.name+'-dialog');
        dialogs[self.name] = self;
        self.on_post_init();
        /*$(function(){
            self.$dialog = $('#'+self.name+'-dialog');
            dialogs[self.name] = self;
            self.on_post_init();
        });*/
   },

   on_post_init: function(){},
   on_pre_show: function(){},
   on_post_show: function(){},

   show: function(owner)
   {
        this.owner=owner;
        this.on_pre_show();
        $('.dialog-layer').show();

        this.on_post_show();
        this.$dialog.fadeIn('fast');
        this.$dialog.center();

   },

    dismiss: function()
    {
        this.$dialog.fadeOut('fast');
        $('.dialog-layer:first').hide();
        this.owner.shade(false);
        this.owner.active_dialog='';
        this.owner.check_selected();
    }


});

ThrobberDialog = new Class({
    _extends: Dialog,
    name:'loading'

});

loading_dialog = new ThrobberDialog();


SignupDialog = new Class({
    _extends: Dialog,
    name: 'signup',

    on_post_show: function(){
        this.$dialog.find('iframe').show().attr('src', "/accounts/create-inline/");
    }

});

signup_dialog = new SignupDialog();


$(function(){

    DEFAULT_ICON_SIZE = parseInt($('#default_icon_size').val());
    DEFAULT_STACK_URL = $('#stack_icon_url').val();
    DEFAULT_STACK_SIZES = eval($('#stack_icon_sizes').val());
    MEDIA_URL = $('#media_url').val();
    NEW_DESKTOP = $('#new_desktop').val() == 'True';


    app.desktop = new Desktop('.desktop');
    desktop = app.desktop;

    //app.on_new_signup = function(fwd_url)
    //{
    //    alert(fwd_url);
    //}

    if (desktop_initial_state)
    {
       desktop.set_state(desktop_initial_state);
    }

    desktop.undo_step();

    desktop.check_selected();
    desktop.save_position = desktop.update_position;

    //loading_dialog.dismiss();

    //if (new_urls=="select")
    //{
    //    desktop.show_dialog('signup', true);
    //    $('iframe').contents().find('input:first').focus();
    //}
    //else

    if(new_urls)
    {
        desktop.show_dialog('loading');
        var $throbber = $('#loading-dialog');
        function on_new_icons(remote)
        {
            desktop.shade(false);
            loading_dialog.dismiss();
            //$throbber.hide();
            desktop.on_new_icons(remote.response.icons, true);
            //desktop.show_dialog('signup', true);
            //$('iframe').contents().find('input:first').focus();
        }

        //$throbber.fadeIn();
        //$throbber.center();

        setTimeout(function(){desktop.api('add_icons', {urls:new_urls.join('|')}, on_new_icons);}, 50);

    } else {
        var dialog = $('#initial_dialog').val();

        if (dialog) {
            if (dialog=='hai') {
                popup('hai');
            } else {
                desktop.show_dialog(dialog);
            }
        } else {
            if(desktop.is_blank()){
                popup('hai');

            }
        }
    }

});

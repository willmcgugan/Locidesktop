
NewIconDialog = new Class({
    _extends: Dialog,
    name: 'new-icon',


    _init:function()
    {
        this._init_super();
        this.api_call=0;
        this.auto_complete_timer_id=null;

        this.selection = null;
        this.auto_count = 0;
        this.url_count = 0;

        this.new_icon_template = '<div class="new-icon" title="{{ url }}"><img src="/media/images/icon-load-throbber.gif" /><div class="url-label">{{ url }}</div></div>';
        this.new_icons = [];
        this.first_show = true;
        this.auto_complete_cache = {};
        this.lookup_cache = {};
        this.on_char_urls = {};
    },

    on_post_show:function()
    {
        var self=this;
        function set_focus(){
            self.$dialog.find('#new-icon-url').focus();
        }
        setTimeout(set_focus, 50);

    },

    on_pre_show:function()
    {
        dynamic_preload("/media/iconsets/crystal_project/48x48/devices/Globe2.png");
        dynamic_preload("/media/images/icon-load-throbber.gif");
        var $url = this.$dialog.find('#new-icon-url');
        $url.val('');
        if (!this.first_show) return;
        this.first_show=false;
        var self=this;
        var desktop = this.owner;
        $url.attr('autocomplete', 'off');
        $(window).click(function()
        {
            self.hide_auto_complete();
        });

        if (!this.one_char_urls) {
            desktop.api('get_one_char_lookups', {}, function(remote){
               self.one_char_urls = remote.response.one_char_urls;
            });
        }

        this.$dialog.find('.dialog-dismiss').click(function() {
            self.dismiss();
        });


        this.$dialog.find('input[name=url]').focus();
        self.$dialog.keydown(function(e){
        //$(window).keyup(function(e){
            if (e.keyCode == KEY_DOWN || e.keyCode == KEY_UP) return;
            self.selection = null;

            var $ul = self.$dialog.find('ul.autocomplete:first');
            var $li = $ul.find('li');
            $li.removeClass('selected');

            var lookup_url = $url.val();

            if (e.keyCode >= 32) {
                lookup_url += String.fromCharCode(e.keyCode);
            }

            function ajax_auto_complete(remote)
            {
                var cached_lookup = self.lookup_cache[lookup_url];

                if (cached_lookup!==undefined) {
                    var urls = cached_lookup.response.urls;
                    self.auto_complete_urls = urls.slice(0);
                    self.search_url = cached_lookup.response.search_url;
                    self.looking_up_url = null;
                    self.update_auto_complete();
                    return;
                } else {
                    var urls = remote.response.urls;
                }
                self.lookup_cache[lookup_url] = remote;
                if(urls!==undefined && remote.call_id == self.call_id)
                {
                    self.auto_complete_urls = urls.slice(0);
                    self.search_url = remote.response.search_url;
                    self.looking_up_url = null;
                    self.update_auto_complete();
                }

            }

            if (lookup_url == self.previous_url) return;
            if(lookup_url){
                function get_auto_complete() {
                    var auto_url = $url.val();
                    if (self.looking_up_url == auto_url) {
                        return;
                    }
                    if (!auto_url) {
                        self.clear_auto_complete();
                        return;
                    }
                    self.looking_up_url = auto_url;
                    var cached_lookup = self.lookup_cache[lookup_url];

                    //alert(lookup_url.length);
                    lookup_url = lookup_url.toLowerCase()
                    if (lookup_url.length==1 && self.one_char_urls && self.one_char_urls[lookup_url]!==undefined) {
                        var urls = self.one_char_urls[lookup_url];
                        self.auto_complete_urls = urls.slice(0);
                        self.search_url = auto_url;
                        self.looking_up_url = null;
                        self.update_auto_complete();
                    } else {
                        if (cached_lookup!==undefined) {
                            ajax_auto_complete(cached_lookup);
                        } else {
                            self.call_id = desktop.api('lookup_url', {url:auto_url}, ajax_auto_complete);
                        }
                    }
                }
                if (self.auto_complete_timer_id) {
                    clearTimeout(self.auto_complete_timer_id);
                }
                self.auto_complete_timer_id = setTimeout(get_auto_complete, AUTO_COMPLETE_DELAY);

            } else {
                self.auto_complete_urls = [];
                self.call_id=null;
                self.update_auto_complete();
            }
            self.previous_url = lookup_url;

        }).keydown(function(e){
            if (e.keyCode==KEY_RETURN)
            {
                self.retrieve_icon();
                return false;
            }
            if (e.keyCode==KEY_ESCAPE)
            {
                self.hide_auto_complete();
            }
            if (e.keyCode==KEY_DOWN || e.keyCode==KEY_UP)
            {
                if(!self.auto_count) return true;
                if(self.selection==null)
                {
                    self.original_url = $url.val();
                }
                if (e.keyCode==KEY_DOWN)
                {
                    if (self.selection==null) {
                        self.selection = 0;
                    } else {
                        self.selection += 1;
                    }
                    self.selection %= self.auto_count;
                } else {
                    if (self.selection==null) {
                        self.selection = self.auto_count-1;
                    } else {
                        self.selection -= 1;
                    }
                    if (self.selection < 0) {
                        self.selection = self.auto_count-1;
                    }
                }

                var $ul = self.$dialog.find('ul.autocomplete:first');
                var $li = $ul.find('li');
                var $selected_li = $ul.find('#auto-'+self.selection );
                $li.removeClass('selected');
                $selected_li.addClass('selected');

                //var new_url = ($selected_li.html()||'').replace(/^\s+|\s+$/g, '');
                var new_url = self.$dialog.find('#autourl-'+self.selection).val();
                $url.val(new_url);
                self.previous_url = new_url;

                e.stopPropagation();
                return false;

            }
            return true;

        });
        this.$dialog.find('.new-icons-button.ok').click(function(){

            self.$dialog.fadeOut('fast');
            var $throbber = $('#loading-dialog');
            $throbber.fadeIn();
            $throbber.center();

            var urls = [];
            self.$dialog.find('.new-icon').not('.disabled').each(function(){
                var url = $(this).find('.url-label').html();
                urls.push(url);
            });

            self.$dialog.find('table.new-icons').empty();
            self.url_count = 0;
            self.new_urls = [];
            self.check_buttons();

            function on_new_icons(remote)
            {
                $throbber.hide();
                self.$dialog.find('.new-icon').remove();
                self.dismiss();
                self.owner.on_new_icons(remote.response.icons);
                self.$dialog.find('.eg').show();
            }

           desktop.api('add_icons', {urls:urls.join('|')}, on_new_icons);
        });
    },

    update_section: function()
    {
        var self=this;
        var $ul = self.$dialog.find('ul.autocomplete:first');
        var $li = $ul.find('li');
        var $selected_li = $ul.find('#auto-'+self.selection );
        $li.removeClass('selected');
        $selected_li.addClass('selected');
    },

    retrieve_icon: function(r_url)
    {
        this.$dialog.find('.eg').hide();
        var self=this;
        this.clear_auto_complete();
        var $url = this.$dialog.find('input[name=url]');
        $url.focus();
        var url = r_url || $url.val();
        if(!url) return;
        this.url_count++;
        $url.val('');

        var new_icon_html = this.new_icon_template.f({url:url});
        var $new_icons = self.$dialog.find('.new-icons:first');
        var $new_icon = $(new_icon_html);
        $new_icons.append($new_icon);

        var $container = this.$dialog.find('.new-icons-container:first');
        $new_icon.show();//fadeIn('slow');

        $new_icon.click(function(){
            $new_icon.fadeOut(function(){
                $new_icon.remove();
                if (!$('.new-icon').length) {
                    $('.new-icons-button-container').hide();
                }
                self.$dialog.center(true);
            });
            /*if ($new_icon.hasClass('disabled')) {
                $new_icon.removeClass('disabled');
            } else {
                $new_icon.addClass('disabled');
            }*/

        });

        desktop.api('get_favicon', {url:url, size:'48'}, function(remote){
            if (remote.response.result=='found'){
                var icon_url = remote.response.icon_url;
                dynamic_preload(icon_url, function(){
                    $new_icon.find('img').attr({'src':icon_url});
                });
                var icon48_url = icon_url.replace('icon16','icon48');
                dynamic_preload(icon48_url);
            } else {
                $new_icon.find('img').attr({'src':"/media/iconsets/crystal_project/48x48/devices/Globe2.png"});
            }
        });



        $container[0].scrollTop = $container[0].scrollHeight;

        this.check_buttons();

        //$('.remove-new-icon').unbind('click').click(function(){
        //    $(this).parent().parent().fadeOut('fast', function(){
        //        $(this).remove();
        //        self.$dialog.center(true);
        //    });
        //
        //    self.url_count--;
        //    self.check_buttons();
        //    self.$dialog.center(true);
        //});

        //$('.url-label').unbind('click').click(function(){
        //    var url = $(this).html();
        //    self.$dialog.find('input[name=url]').val(url);
        //});

        this.$dialog.center(true);
    },

    check_buttons: function()
    {
        if (this.url_count) {
            $('.new-icons-button-container').show();
            this.$dialog.find('.new-icons-container:first').show();
        } else {
            $('.new-icons-button-container').hide();
            this.$dialog.find('.new-icons-container:first').hide();
        }
    },

    clear_auto_complete: function()
    {
        var self=this;
        var $ul = this.$dialog.find('ul.autocomplete:first');
        $ul.hide();
        self.selection = null;
        this.auto_count = 0;
        $ul.html('');
    },

    hide_auto_complete: function()
    {
        this.$dialog.find('ul.autocomplete:first').fadeOut('fast');
        this.selection = null;
        this.auto_count = 0;
        this.clear_auto_complete();
    },

    update_auto_complete:function()
    {
        var self=this;
        var url_template = '<li id="auto-{{ i }}">{{ display_url }}</li>\n<input id="autourl-{{ i }}" value="{{ url }}" type="hidden">';
        var $ul = this.$dialog.find('ul.autocomplete:first');

        var lis = "";
        this.auto_count = this.auto_complete_urls.length;
        if (this.auto_count) {
            $.each(this.auto_complete_urls, function(i, url) {
                var display_url = url.replace(self.search_url, '<span class="auto-highlight">' + self.search_url + '</span>');
                lis += url_template.f({url:url, display_url:display_url, i:i});
            });
            $ul.html(lis);
            $ul.show();
        } else {
            $ul.hide();
        }

        $ul.find('li').mousemove(function() {
            var $li = $(this);
            var selection = parseInt($li.attr('id').split('-')[1]);
            self.selection = selection;
            self.update_section();
        }).click(function() {
            var $url = self.$dialog.find('input[name=url]');
            var $li = $(this);
            var selection = parseInt($li.attr('id').split('-')[1]);
            var new_url = self.$dialog.find('#autourl-'+selection).val();
            //var new_url = ($li.html()||'').replace(/^\s+|\s+$/g, '');
            //$url.val(new_url);
            self.previous_url = new_url;
            self.retrieve_icon(new_url);
        });

        self.selection = null;
        this.$dialog.center(true);
    }

});
new_icon_dialog = new NewIconDialog();

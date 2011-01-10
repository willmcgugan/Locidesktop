
EditIconDialog = new Class({
   _extends: Dialog,
   name: 'edit-icon',

    _init: function()
    {
        this._init_super();
        this.icon = null;
        this.icon_catalogs = null;

        this.icon_template='<div class="icon-select{{ selected }}" title="{{ name }}" id="selecticon-{{ name }}"><div class="icon-select-expand" id="selectionexpand-{{ name }}"></div></div>';

        this.new_icon = null;
    },

    show_tab: function(tab)
    {
        this.$dialog.find('.tab-panel').removeClass('active');
        this.$dialog.find('.'+tab).addClass('active');

        this.$dialog.find('ul.dialog-tabs li').removeClass('active');
        this.$dialog.find('ul.dialog-tabs li#show-tab-'+tab).addClass('active');
    },

    on_pre_show: function()
    {
        var self = this;
        var icon = this.owner.get_selected_icons()[0];
        this.icon = icon;
        this.new_icon = null;


        this.show_tab('visual');

        this.$dialog.find('input[name=name]').val(icon.name || '');
        this.$dialog.find('input[name=description]').val(icon.description || '');

        if (icon.has_favicon && icon.use_favicon) {
           this.$dialog.find('#custom-icon-checkbox').attr('checked', false);
           this.$dialog.find('.pack-selector,.pack-list-container').hide();
        } else {
           this.$dialog.find('#custom-icon-checkbox').attr('checked', true);
           this.$dialog.find('.pack-selector,.pack-list-container').show();
        }

        if (icon.type == 'stack')
        {
            this.$dialog.find('tr.not-stack').hide();
        }
        else
        {
            this.$dialog.find('tr.not-stack').show();
            this.$dialog.find('input[name=url]').val(icon.url || '');
            this.$dialog.find('input[name=search_url]').val(icon.search_url || '');
        }
        this.$dialog.find('textarea[name=icon-details]').val(icon.notes || '');
        this.changed = false;

        $icon_img = this.$dialog.find('.icon-image img');
        $icon_img.attr('src', icon.icon_img);

        this.$dialog.find('#icon-visual-tab .pack-selector').load('/iconpacks/', {}, function(){
            self.$icon_select = $("#icon-pack-select");

            self.$icon_select.change(function(e){

               var $pack_icon_list = self.$dialog.find('.pack-icon-list');
               var new_catalog = self.$icon_select.val();

               $pack_icon_list.html('<div class="loading-icon-pack">Loading icon pack...</div>');
               $pack_icon_list.css({'background-image':'none'})

               self.owner.api('get_icon_catalog', {name:new_catalog}, function(remote){

                  self.on_load_catalog(remote);

               });

            });

            if (self.icon.icon_key) {
               var cat_info = self.icon.icon_key.split('.');
               var cat_key = cat_info[0] + '.' + cat_info[1];
               //$('#icon-pack-select option[value={{ cat_key }}]'.f({cat_key:cat_key}))
               $('#icon-pack-select').val(cat_key);
               self.owner.api('get_icon_catalog', {name:cat_key}, function(remote){
                  self.on_load_catalog(remote);
               });
            }

        });

    },

    on_load_catalog: function(remote)
    {
      var self = this;
      var $icon_select = $("#icon-pack-select");
      var $pack_icon_list = self.$dialog.find('.pack-icon-list');

      var html = '';
      $pack_icon_list.html('');
      $pack_icon_list.css({'background-image':'url("' + remote.response.preview_url + '")'})

      self.icon_catalog = remote.response.icon_catalog;

      self.catalog_icons = {};
      $.each(remote.response.icons, function(i, icon){
         var name = icon.name;
         self.catalog_icons[name] = icon;
         var img_url = icon.img_url.replace(/\[SIZE\]/g, '32');
         img_url = img_url.replace('.png', '.jpg');

         var selected = "";
         if (self.icon_catalog+'.'+name == self.icon.icon_key) {
            selected = " selected";
         }

         var icon_html = self.icon_template.f({name:name, img_url:img_url, selected:selected });
         html += icon_html;
      });

      $pack_icon_list.html(html);

      $('#custom-icon-checkbox').click(function(e){
         var $checkbox = $(this);
         if ($checkbox.is(':checked')) {
            $('.pack-selector,.pack-list-container').show();
            self.icon.use_favicon = false;
            self.changed = true;
         } else {
            $('.pack-selector,.pack-list-container').hide();
            self.icon.use_favicon = true;
            self.changed = true;
         }
      });


      $('.pack-icon-list .icon-select').mousemove(function(e) {

         var $icon = $(this);
         var icon_rect = new ElementRect($icon[0]);
         function show_select_icon()
         {
            var pack_offset = self.$dialog.find('.pack-icon-list').offset();
            var offset = $icon.offset();
            var icon_name = $icon.attr('id').match(/-(.*?)$/)[0].substr(1);

            var $expanded = $('#selectionexpand-'+icon_name);

            var img_url = self.catalog_icons[icon_name].img_url;
            img_url = img_url.replace(/\[SIZE\]/g, '64');
            var css = icon_rect.p1.minus({x:16,y:16}).css();
            css['background-image'] = 'url("' + img_url + '")';
            $expanded.css(css);

            $expanded.fadeIn('fast');

            return false;
         }

         if(self.show_select_icon_timer) {
            clearTimeout(self.show_select_icon_timer);
            self.show_select_icon_timer = null;
            $('.icon-select-expand:visible').hide();
         }
         self.show_select_icon_timer = setTimeout(show_select_icon, 250);

      }).mouseleave(function(e){
         if(self.show_select_icon_timer) {
            clearTimeout(self.show_select_icon_timer);
            self.show_select_icon_timer = null;
            $('.icon-select-expand:visible').hide();
         }
      }).click(function(e) {
         var $icon = $(this);
         var icon_name = $icon.attr('id').match(/-(.*?)$/)[0].substr(1);
         self.$dialog.find('.icon-select').removeClass('selected');
         $icon.addClass('selected');

         self.new_icon = self.catalog_icons[icon_name];
         self.new_icon_key = self.icon_catalog + '.' + icon_name;
         //self.new_icon_sizes = self.catalog_icons[icon_name].sizes.splice(0);
         self.changed = true;

      });
    },

    on_post_init: function()
    {
        var self = this;
        this.$dialog.find('input,textarea').change(function(){
            self.changed = true;
        });
        this.$dialog.find('.edit-icons-button.ok').click(function(){

            if (!self.changed) {
                self.dismiss();
                return;
            }

            if (self.new_icon) {
               self.icon.set_new_icon(self.new_icon, self.new_icon_key);
            } else {
               self.icon.change_size(0);
            }

            var name = self.$dialog.find('input[name=name]').val();
            self.icon.set_name(name);
            var description = self.$dialog.find('input[name=description]').val();
            self.icon.description = description;

            if (self.icon.type != 'stack')
            {
                var url = self.$dialog.find('input[name=url]').val();
                var search_url = self.$dialog.find('input[name=search_url]').val();
                self.icon.url = url;
                self.icon.search_url = search_url;
            }

            var icon_details = self.$dialog.find('textarea[name=icon-details]').val();
            self.icon.notes = icon_details;
            self.icon.set_state(self.icon.get_state());

            self.owner.undo_step();
            self.dismiss();

        });
        this.$dialog.find('.dialog-dismiss').click(function() {
            self.dismiss();
        });
        this.$dialog.find('.dialog-tabs li').click(function() {
            var $this = $(this);
            self.$dialog.find('.dialog-tabs li').removeClass('active');
            $this.addClass('active');
            var id = $this.attr('id');
            var panel = id.substr("show-tab-".length);

            $('.tab-panel').removeClass('active');
            $('.'+panel).addClass('active');
            self.$dialog.center(true);
        });

    }
});
edit_icon_dialog = new EditIconDialog();
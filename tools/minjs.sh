cp ../webapp/linkstop/media/js/*.js ../webapp/linkstop/media/minijs/

for f in desktop.js desktop_view.js desktop_common.js new_icon_dlg.js edit_icon_dlg.js visited.js desktop_list.js

do

java -jar yuicompressor-2.4.2.jar ../webapp/linkstop/media/js/$f -o ../webapp/linkstop/media/minijs/$f

done

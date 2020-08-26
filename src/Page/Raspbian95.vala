/*
* Copyright (c) 2011-2020 ThemeSwitcher
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Kris Henriksen <krishenriksen.work@gmail.com>
*/

using Gtk;

namespace ThemeSwitcher {
    public class Raspbian95 : Gtk.Box {
        public Raspbian95 () {
            var wrapper = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            wrapper.get_style_context ().add_class ("theme");

	        var pixbuf = new Gdk.Pixbuf.from_file("/usr/local/share/themeswitcher/raspbian95.png");
	        pixbuf = pixbuf.scale_simple(200, 112, Gdk.InterpType.BILINEAR);

			var image = new Gtk.Image();
			image.set_from_pixbuf(pixbuf);
			image.get_style_context ().add_class ("themeswitcher_image");

			wrapper.add(image);

            var button_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            button_box.get_style_context ().add_class ("themeswitcher_box");   

			var button = new Gtk.Button.with_label ("Raspbian95...");
			button.get_style_context().add_class ("themeswitcher_button");
			button.clicked.connect (() => {
		        try {
		        	GLib.AppInfo info = AppInfo.create_from_commandline("xfce4-terminal --title=Config --hide-menubar --hide-borders --hide-scrollbar -e \"/usr/share/ThemeSwitcher/ThemeTwister.sh Raspbian95\"", null, AppInfoCreateFlags.SUPPORTS_STARTUP_NOTIFICATION);
		        	info.launch(null,Gdk.Display.get_default().get_app_launch_context());
		        } catch (GLib.Error e){warning ("Could not load Config: %s", e.message);}
			});

			button_box.add(button);

			wrapper.add(button_box);
       
            this.add(wrapper);
        }
    }
}
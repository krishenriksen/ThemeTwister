/*
* Copyright (c) 2011-2020 ThemeTwister
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

namespace ThemeTwister {
    public class iTwisterSur : Gtk.Box {
        public iTwisterSur () {
            var wrapper = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            wrapper.get_style_context ().add_class ("theme");

	        var pixbuf = new Gdk.Pixbuf.from_file("/usr/local/share/themetwister/iRaspbianSur.png");
	        pixbuf = pixbuf.scale_simple(200, 112, Gdk.InterpType.BILINEAR);

			var image = new Gtk.Image();
			image.set_from_pixbuf(pixbuf);
			image.get_style_context ().add_class ("themetwister_image");

			wrapper.add(image);

            var button_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            button_box.get_style_context ().add_class ("themetwister_box");   

			var button = new Gtk.Button.with_label ("Light");
			button.get_style_context().add_class ("themetwister_button");
			button.clicked.connect (() => {
		        try {
		        	GLib.AppInfo info = AppInfo.create_from_commandline("xfce4-terminal --title=Config --hide-menubar --hide-borders --hide-scrollbar -e \"/usr/share/ThemeSwitcher/ThemeTwister.sh iRaspbianSur\"", null, AppInfoCreateFlags.SUPPORTS_STARTUP_NOTIFICATION);
		        	info.launch(null,Gdk.Display.get_default().get_app_launch_context());
		        } catch (GLib.Error e){warning ("Could not load Config: %s", e.message);}
			});

			button_box.add(button);

			button = new Gtk.Button.with_label ("Dark");
			button.get_style_context().add_class ("themetwister_button");
			button.clicked.connect (() => {
		        try {
		        	GLib.AppInfo info = AppInfo.create_from_commandline("xfce4-terminal --title=Config --hide-menubar --hide-borders --hide-scrollbar -e \"/usr/share/ThemeSwitcher/ThemeTwister.sh iRaspbianSur-Dark\"", null, AppInfoCreateFlags.SUPPORTS_STARTUP_NOTIFICATION);
		        	info.launch(null,Gdk.Display.get_default().get_app_launch_context());
		        } catch (GLib.Error e){warning ("Could not load Config: %s", e.message);}
			});

			button_box.add(button);

			wrapper.add(button_box);

	        var description = new Label ("iTwister Sur");
			description.set_line_wrap_mode(Pango.WrapMode.WORD);
			description.set_line_wrap(true);
			description.set_lines(1);
			description.set_justify(Justification.CENTER);
			description.get_style_context ().add_class("themetwister_description_label");			

			wrapper.add(description);			
       
            this.add(wrapper);
        }
    }
}
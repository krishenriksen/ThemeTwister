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

public class ThemeTwisterWindow : Window {

	private Stack stack;
	private int current_page = 1;
	private Button cancel_or_previous;
	private Button next;

    public ThemeTwisterWindow () {
        this.set_title ("themetwister");
        this.set_skip_pager_hint (true);
        this.set_skip_taskbar_hint (true); // Not display the window in the task bar
        this.set_decorated (false); // No window decoration
        this.set_app_paintable (true); // Suppress default themed drawing of the widget's background
        this.set_visual (this.get_screen ().get_rgba_visual ());
        this.set_type_hint (Gdk.WindowTypeHint.NORMAL);
        this.resizable = false;
        this.window_position = Gtk.WindowPosition.CENTER;

        this.set_default_size (800, 400);


        var grid = new Grid();
        grid.get_style_context().add_class ("themetwister");
        this.add(grid);

        stack = new Stack();
    	stack.set_transition_type(Gtk.StackTransitionType.SLIDE_LEFT_RIGHT);
    	stack.set_transition_duration(500);
        stack.set_vexpand(true);
        stack.set_hexpand(true);
        grid.attach(stack, 0, 0, 2, 1);

        this.cancel_or_previous = new Button.with_label("Cancel");
        cancel_or_previous.get_style_context().add_class ("cancel_or_previous");
    	this.cancel_or_previous.clicked.connect ( () => {
    		this.next.label = "Next";

    		if (this.current_page > 1) {
    			this.current_page -= 1;

    			if (this.current_page == 1) {
    				this.cancel_or_previous.label = "Cancel";
    			}

    			stack.set_visible_child_name(this.current_page.to_string());
    		}
    		else {
    			this.destroy();
    		}
    	});
        grid.attach(this.cancel_or_previous, 0, 1, 1, 1);

        this.next = new Button.with_label("Next");
        this.next.get_style_context().add_class ("next");
    	this.next.clicked.connect ( () => {
    		this.cancel_or_previous.label = "Previous";

    		if (this.current_page < 2) {
				this.current_page += 1;
    			stack.set_visible_child_name(this.current_page.to_string());

    			if (this.current_page == 2) {
    				this.next.label = "Get Started";
    			}
    		}
    		else {
    			this.destroy();
    		}
    	});
        grid.attach(this.next, 1, 1, 1, 1);

		var main_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        main_box.get_style_context ().add_class ("themetwister_box");

        // add pages
        stack.add_named(new ThemeTwister.Welcome(), "1");
        
		var box1 = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        box1.get_style_context ().add_class ("themetwister_main_box");

        box1.add(new ThemeTwister.TwisterOS());
		box1.add(new ThemeTwister.Raspbian95());
		box1.add(new ThemeTwister.RaspbianXP());
		box1.add(new ThemeTwister.Nighthawk());

        main_box.add(box1);

		var box2 = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        box2.get_style_context ().add_class ("themetwister_main_box2");

        box2.add(new ThemeTwister.RaspbianX());
        box2.add(new ThemeTwister.iRaspbian());
       	box2.add(new ThemeTwister.iRaspbianDark());

        main_box.add(box2);

        stack.add_named(main_box, "2");

		this.show_all();
    }

    // Override destroy for fade out and stuff
    private new void destroy () {
        base.destroy();
        Gtk.main_quit();
    }
}

static int main (string[] args) {
    Gtk.init (ref args);
    Gtk.Application app = new Gtk.Application ("dk.krishenriksen.themetwister", GLib.ApplicationFlags.FLAGS_NONE);

    // check for light or dark theme
    File iraspbian = File.new_for_path (GLib.Environment.get_variable ("HOME") + "/.iraspbian-dark.twid");
    File nighthawk = File.new_for_path (GLib.Environment.get_variable ("HOME") + "/.nighthawk.twid");

    string css_file = Config.PACKAGE_SHAREDIR +
        "/" + Config.PROJECT_NAME +
        "/" + (iraspbian.query_exists() || nighthawk.query_exists() ? "themetwister_dark.css" : "themetwister.css");
    var css_provider = new Gtk.CssProvider ();

    try {
        css_provider.load_from_path (css_file);
        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default(), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER);
    } catch (GLib.Error e) {
        warning ("Could not load CSS file: %s",css_file);
    }

    app.activate.connect( () => {
        if (app.get_windows ().length () == 0) {
            var main_window = new ThemeTwisterWindow ();
            main_window.set_application (app);
            main_window.show();
            Gtk.main ();
        }
    });
    app.run (args);

    return 1;
}

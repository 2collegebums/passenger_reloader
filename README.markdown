Passenger Reloader
==============

Purpose
-------

  Using rails, there are certain folders that require a restart such as anything in config. Also, when developing engines, we ran into some reloading dependency issues which seemed difficult to debug. We decided that a low-memory daemon which restarts whenever certain files are changed would be a good way to manage this issue. This simple script will watch your rails application directory for changes in:

 * `[rails_root]/config`
 * `[any_engine]/app/models`
 * `[any_engine]/lib`
 * `[any_engine]/config`

If changes on these paths are detected, the passenger server will be restarted with the command `touch /tmp/restart.txt`. You may want to use this script if you are developing plugins or just get tired of restarting when changing initializers or routes.

Usage
------

ruby lib/smart_reloader/daemon.rb PATH_TO_RAILS_APP OPTIONS_LIST

Options

 * -l lib
 * -c config
 * -g vendor/gems
 * -p vendor/plugins

 * the default options are -l and -c

Example call
		
ruby lib/smart_reloader/daemon.rb ~/apps/my_app -l -c -g
		
If you are using mac os x, it will smartly observe FSEvent to prevent the need for file polling. If on a linux distribution it will fall back to file polling. If there is a hook on linux, we would like a patch. On mac the notifications will be using growl and growlnotify. If not, the notifications will be directed to stdout.

Dependencies
------------

 * Unix-based system (fails on windows)
 * Mac OS X >= 10.5 (for FSEvent instead of filesystem polling)
 * Growl and growlnotify (only if on mac)

Shoutouts
----------

Thanks to Sven Schwyn for the fsevent handling he created for his awesome project [autotest-mac](http://github.com/svoop/autotest-mac/tree/master "autotest-mac").
Thanks to autotest for giving us the inspiration to create this daemon.
 
License
--------

(The MIT License)

Copyright © 2009 2CollegeBums

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
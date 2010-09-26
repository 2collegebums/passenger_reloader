module PassengerReloader
class ReloadServer
  def initialize(*args)
    args.flatten!.compact!
    @base_dir = (args.size > 0 && args.first.chars.first != '-') ? File.expand_path(args.shift) : Dir.pwd
    args = ['-c', '-l'] if args.size == 0
    @watched_dirs = args.collect {|a| convert_to_path(a)}
    @last_time = Time.now
    @interrupted = false
    notify('Started Reload Server', "Started reload server at #{@last_time.strftime('%I:%M:%S %p')}. Checking for changes in #{@base_dir} to files in #{@watched_dirs.inspect}.")
    add_sigint_handler
    setup_wait_system
  end

  def convert_to_path(option)
    {:c => 'config', :l => 'lib', :g => 'vendor/gems', :p => 'vendor/plugins'}[option.chars.to_a[1].intern]
  end

  def run
    loop do
      @wait_system.call
      check_files_need_reloading
    end
  end

  def setup_wait_system
    if using_mac?
      @wait_system = lambda { `#{current_path_to_file('fsevent_sleep')} '#{@base_dir}' 2>&1` }
    else
      notify "Using File Polling", " FSEvent was not detected."
      @wait_system = lambda { Kernel.sleep 1 }
    end
  end

  def check_files_need_reloading(force=false)
    @interrupted = false
    if(force or files_have_changed)
      `touch #{restart_file = path_to_file('tmp/restart.txt')}`
      notify('Server Restarting', "Changes have been detected at #{@last_time.strftime('%I:%M:%S %p')}. Restarting application server.")
      @last_time = File.mtime(restart_file)
    end
  end

  def files_have_changed
    file_changed_array = @watched_dirs.collect{ |dir| files_have_changed_in_path("#{@base_dir}/#{dir}") }

    Dir.glob("#{@base_dir}/vendor/plugins/*/app").each do |f|
      plugin_model_directory = File.dirname(f)
      ["app/models", "lib", "config"].each { |sub| file_changed_array << files_have_changed_in_path(plugin_model_directory + "/#{sub}") }
    end
    file_changed_array.any?
  end

  def files_have_changed_in_path(model_path)
    newest_time = Dir.glob(model_path + "/**/*").collect do |file|
      File.mtime(file) if File.mtime(file) > @last_time
    end.compact.max
    return !newest_time.nil?
  end

  def path_to_file(path)
    @base_dir + "/#{path}"
  end

  def current_path_to_file(path)
    File.dirname(__FILE__) + "/#{path}"
  end

  def add_sigint_handler
    trap 'INT' do
      if @interrupted then
        break;
      else
        puts "\nPress ^C again to terminate.\n"
        @interrupted = true
        Kernel.sleep 1.5
        check_files_need_reloading(true)
      end
    end
  end

  ##
  # Display a message through Growl.
  def notify title, message=""
    return puts("#{title}: #{message}") unless using_mac?
    icon = current_path_to_file('restart_icon.png')
    system "growlnotify -H localhost -n autotest --image '#{icon}' -m #{message.inspect} '#{title}'"
  end

  # Darwin 9 alias Mac OS X 10.5 or above only
  def using_mac?
    @using_mac ||= RUBY_PLATFORM.sub(/^.*?darwin(\d+).*$/, '\1').to_i >= 9
  end
end
end


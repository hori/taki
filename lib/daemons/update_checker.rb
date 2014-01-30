#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "production"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, "config", "environment")

$running = true
Signal.trap("TERM") do
  $running = false
end

while($running) do
  # Replace this with your code
  # Rails.logger.auto_flushing = true
  # Rails.logger.info "This daemon is still running at #{Time.now}.\n"

  @files = YAML.load(File.read('config/files.yml'))
  processor = ActiveSupport::FileUpdateChecker.new(@files['stylesheets']) do
    #TODO: @files['stylesheets'] updated!
    puts "process to stylesheets!"
  end
  puts processor.execute_if_updated

  sleep 5
end

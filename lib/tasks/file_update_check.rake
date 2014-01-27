namespace :file_update_check do
  desc "config/files に設定された fileが更新されたかどうかチェックして実行する"

  task :check => :environment do
    @files = YAML.load(File.read('config/files.yml'))

    checker = ActiveSupport::FileUpdateChecker.new(@files['stylesheets']) do
        puts checker
    end
    puts @files
  end
end

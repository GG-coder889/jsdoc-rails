require 'rails/generators'
require 'rails/generators/migration'     

class JsdocGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      if @previous_migration_number
        @previous_migration_number += 1
      else
        @previous_migration_number = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
      end

      return @previous_migration_number.to_s
    else
      return "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def create_migration_files
    migration_templates = File.join(File.dirname(__FILE__), 'templates/migrations/')

    Dir.foreach(migration_templates) do |f|
      next unless f.ends_with?('.rb')

      optional_migration_template "migrations/#{f}", "db/migrate/#{f}"
    end
  end

  def copy_static_assets
    assets = ['public/images/jsdoc/', 'public/stylesheets/jsdoc/', 'public/javascripts/jsdoc/'];

    assets.each do |a|
      asset_dir = File.join(File.dirname(__FILE__), '../../../', a)
      copy_dir(asset_dir, a)
    end
  end

  private

    def copy_dir(src, dst)
      Dir.foreach(src) do |f|
        next if %w(. ..).include?(f)
        src_file = File.join(src, f)
        dst_file = File.join(dst, f)

        if File.directory?(src_file)
          copy_dir(src_file, dst_file)
        else
          copy_file(src_file, dst_file)
        end

      end
    end

    def optional_migration_template(*args)
      migration_template(*args)
    rescue Exception => e
      if e.message.include?('Another migration is already named')
        puts "Skipping existing migration: #{args[1]}"
        return
      else
        raise e
      end
    end
end

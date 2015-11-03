require "pgclone/version"

module Pgclone
  
  class Configuration
    attr_accessor :owner, :appname, :local_db, :file
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield( configuration )
  end

  class Restore
    attr_accessor :appname, :owner, :local_db, :file
    def initialize(opts={})
      @appname = opts[:appname] || config(:appname)
      @owner = opts[:owner] || config(:owner)
      @local_db = opts[:local_db] || config(:local_db)
      @file = opts[:file] || config(:file) || 'latest.dump'
      raise_missing_keys!
    end

    def config(key)
      Pgclone.configuration.send(key)
    end

    def go!
      capture_backup
      grab_dump
      restore_db
    end

    private

    def raise_missing_keys!
      [:appname, :owner, :local_db].each do |key|
        raise "Missing required option: #{key}." unless instance_variable_get("@#{ key }")
      end
    end

    def capture_backup
      puts "Capturing new backup"
      `heroku pg:backups capture --app #{appname}`
      puts "Captured the production database"
    end

    def grab_dump
      "Finding DB URL"
      url = `heroku pg:backups public-url --app #{appname}`.split(" ").last.strip
      puts "Dumping database to #{file}"
      `curl -o #{file} "#{url}"`
    end

    def restore_db
      puts "Restoring local DB"
      `pg_restore --verbose --clean --no-acl --no-owner -h localhost -U #{owner} -d #{local_db} #{file}`
      
      puts "Local database restored"
      `rm #{file}`
      puts "#{file} removed"
    end
  end
end

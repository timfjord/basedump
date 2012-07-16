require "thor"

module Basedump
  class CLI < Thor
    
    desc "configure", "Create configuration file"
    def configure
      config_file = File.expand_path('.basedump', '.')
      
      opt = {}
      opt[:domain] = Basedump::Dumper::DOMAIN % 
        [ ask('Please enter your domain(<yourdomain>.basecamphq.com):') ]
      opt[:username] = ask('Please enter your username:')
      opt[:password] = ask('Please enter your password:')
      opt[:project] = ask('Please enter your project:')
      opt[:use_ssl] = yes?('Use ssl for this project?:')
      
      Basedump::Dumper.connect! opt
      Basedump::Dumper.find_project_id_by_name opt[:project]
      
      File.open(config_file, 'w') do |config|
        YAML.dump(opt, config)
      end
      
      say('Basedump local configuration was successfully stored')
    end
  end
end
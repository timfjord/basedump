require "thor"

module Basedump
  class CLI < Thor
    
    desc "configure", "Create configuration file"
    method_option :global, type: :boolean
    def configure
      config_file = File.expand_path('.basedump', (options[:global] ? '~' : '.'))
      
      opt = {}
      opt[:domain] = Basedump::Dumper::DOMAIN % 
        [ ask('Please enter your domain(<yourdomain>.basecamphq.com):') ]
      opt[:username] = ask('Please enter your username:')
      opt[:password] = ask('Please enter your password:')
      opt[:project] = ask('Please enter your project:')
      opt[:use_ssl] = yes?('Use ssl for this project?:')
      
      puts opt.to_yaml
      
      Basedump::Dumper.connect! opt
      Basedump::Dumper.find_project_id_by_name opt[:project]
      
      File.open(config_file, 'w') { |f| YAML.dump(opt, f) }
      
      say('Basedump %s configuration was successfully stored' % [options[:global] ? 'global' : 'local'])
    end
  end
end
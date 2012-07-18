require "basedump"
require "basecamp"

module Basedump
  class Dumper
    DOMAIN = '%s.basecamphq.com'
    CONFIG_FILE = '.basedump'
    
    attr_reader :config
    
    def initialize(opt = {})
      merge_options opt
    end
    
    private
    
    def merge_options(opt = {})
      klass = self.class
  
      config.merge YAML::load(File.open(klass.global_config)) if klass.global_config_exists?
      config.merge YAML::load(File.open(klass.local_config)) if klass.local_config_exists?
      config.merge opt
      
      self
    end
    
    class << self
      def connect!(opt)
        @@connection ||= Basecamp.establish_connection!(
          opt[:domain], 
          opt[:username], 
          opt[:password], 
          opt[:use_ssl]
        )
      end
      
      def find_project_id_by_name(name)
        projects = Basecamp::Project.find(:all).select { |pr| pr.name =~ /#{Regexp.escape(name)}/ }
        raise NoProjectError, "Cann't find project" if projects.empty?
        projects.first.id
      end
      
      def local_config
        File.expand_path(CONFIG_FILE, '.')
      end
      
      def global_config
        File.expand_path(CONFIG_FILE, '~')
      end
      
      def local_config_exists?
        File.exists? local_config
      end
      
      def global_config_exists?
        File.exists? global_config
      end
    end
  end
end
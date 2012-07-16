require "basedump"
require "basecamp"

module Basedump
  class Dumper
    DOMAIN = '%s.basecamphq.com'
    
    attr_reader :config
    
    def initialize()
    end
    
    class << self
      def configure(opt = nil) 
      end
      
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
    end
  end
end
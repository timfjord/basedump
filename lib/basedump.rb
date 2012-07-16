require "basedump/dumper"
require "basedump/version"
require "active_resource"

module Basedump
  class BasedumpError < ::StandardError; end
  class NoProjectError < BasedumpError; end
end

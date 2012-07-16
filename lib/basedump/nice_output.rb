module Basedump
  def self.nice_output
    @shell = Thor::Shell::Basic.new
    begin
      yield
    rescue ::SocketError
      @shell.say "Cann't connect to domain"
    rescue ::ActiveResource::Redirection
      @shell.say "You should force ssl connection"
    rescue ::ActiveResource::UnauthorizedAccess
      @shell.say "Wrong credentials"
    rescue NoProjectError => e
      @shell.say e.message
    end
  end
end
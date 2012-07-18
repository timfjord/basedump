require 'fileutils'

# hide and restore config files

Before('@hide_config') do
  @global_config = File.expand_path('~/.basedump');
  @local_config = File.expand_path('.basedump', '.')
  { global: @global_config, local: @local_config }.each do |type, orig_name|
    Dir::Tmpname.create("#{type}_basedump_config") do |path| 
      self.instance_variable_set("@temp_#{type}_config", path)
      FileUtils.mv(orig_name, path)
    end if File.exists?(orig_name)
  end
  
end

After('@hide_config') do
  { @global_config => @temp_global_config, @local_config => @temp_local_config }.each do |orig_name, temp_name|
    FileUtils.mv(temp_name, orig_name) if temp_name
  end
end

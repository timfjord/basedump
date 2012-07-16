When /^I specify (valid|invalid) basecamp credetials$/ do |state|
  credentials = YAML::load(File.open(File.expand_path('.basecamp_credentials', '.')))
  credentials["username"] = 'invalid_username' if state == 'invalid'
  credentials.each_value { |k| type(k) }
end

Then /^"([^"]*)" should be valid config file$/ do |file|
  test_credentials = YAML::load(File.open(File.expand_path('.basecamp_credentials', '.')))
  
  #TODO: refactor this
  if file[0] == '~'
    f = File.expand_path('.basedump', '~')
    File.exists?(f).should be_true
    credentials = YAML::load(File.open(f))
    credentials.keys.should == test_credentials.keys.map(&:to_sym)
  else
    check_file_presence([file], true)
    prep_for_fs_check do
      credentials = YAML::load(File.open(file))
      credentials.keys.should == test_credentials.keys.map(&:to_sym)
    end
  end
end
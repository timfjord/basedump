When /^I specify (valid|invalid) basecamp credetials$/ do |state|
  credentials = YAML::load(File.open(File.expand_path('.basecamp_credentials', '.')))
  credentials["username"] = 'invalid_username' if state == 'invalid'
  credentials.each_value { |k| type(k) }
end

Then /^"([^"]*)" should be valid config file(!?)$/ do |file, bang |
  test_credentials = YAML::load(File.open(File.expand_path('.basecamp_credentials', '.')))
  assert = lambda do
    credentials = YAML::load(File.open(file))
    credentials.keys.should == test_credentials.keys.map(&:to_sym)
  end
  if bang.empty?
    prep_for_fs_check &assert
  else
    file = File.expand_path(file)
    assert.call
  end
end

# bang in the end mean that check in real FS

Then /^a file named "([^"]*)" should exist!$/ do |file|
  File.exists?(File.expand_path(file)).should be_true
end

Then /^a file named "([^"]*)" should not exist!$/ do |file|
  File.exists?(File.expand_path(file)).should_not be_true
end
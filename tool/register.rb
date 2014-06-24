#!/usr/bin/ruby
require 'yaml'
require 'fileutils'

SETTING_YAML_FILE_NAME = "setting.yaml"

def create_setting_yaml(path, setting)
  FileUtils.mkdir_p(path)
  open(path + "/" + SETTING_YAML_FILE_NAME,"w") do |f|
    YAML.dump(setting,f)
  end
end

def get_input(description, blank_leave)
  print description
  result = STDIN.gets.chomp
  if (!blank_leave && input_valid?(result))
    puts 'please input'
    result = get_input(description, blank_leave)
  end

  result
end

def input_valid?(input)
  return input == ''
end

package = get_input('input package name(com.example.gradle): ', false)
lib_name = get_input('intput lib name: ', false)
base_url = get_input('lib download base url: ', false)
homepage_url = get_input('lib homepage url: ', false)
authors = get_input('authors: ', false)
summary = get_input('lib summary: ', false)
source_url = get_input('source url: ', false)

puts ''

print(<<"EOS")
package : #{package}
lib name: #{lib_name}
base url: #{base_url}
homepage: #{homepage_url}
authors : #{authors}
summary : #{summary}
source  : #{source_url}
EOS
result = get_input('register ok?(input yes): ', true)
exit unless result == 'yes' || result == 'y'

setting = {
  'name' => lib_name,
  'url'  => base_url,
  'homepage' => homepage_url,
  'authors' => authors,
  'summary' => summary,
  'source' => source_url
}
path = 'repository/' + package.gsub(/\./, '/')

create_setting_yaml(path, setting)

print(<<"EOS")
Create #{path + "/" + SETTING_YAML_FILE_NAME}
Please Pull Request!!
EOS

require 'debugger'
require 'yaml'
require_relative 'lib/proxy.rb'

BASE = 'http://repo1.maven.org/maven2'
config = YAML.load_file('settings.yaml')

use Proxy
app = Proc.new do |env|
  pp env
  path = env['SCRIPT_NAME'] + env['PATH_INFO']

  array = []
  env['PATH_INFO'].split('/').each do |s|
    if /^\d+(\.\d+)?/ =~ s
      break
    end
    array.push(s) if s != ''
  end
  pp array
  
  tmp_config = config;
  array.each do |key|
    tmp_config = tmp_config[key] unless tmp_config[key].nil? 
  end
  pp tmp_config['url']
  url = tmp_config['url']

  path << "?#{env['QUERY_STRING']}" unless env['QUERY_STRING'].empty?
  if url.nil?
    [404, {}, ['']]
  else
    [301, { 'Location' => url + path }, ['']] unless url.nil?
  end
end

run app

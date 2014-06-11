require 'rack-proxy'
require 'debugger'
require_relative 'model/find.rb'

class Proxy < Rack::Proxy
  NOT_FOUND_BASE_URL = 'http://henteko07.com'
  MAVEN_METADATA_FILE_NAME = 'maven-metadata.xml'

  def initialize(app)
    @app = app
  end

  def rewrite_env(env)
    path = env['SCRIPT_NAME'] + env['PATH_INFO']

    project_path = ''
    env['PATH_INFO'].split('/').each do |s|
      break if /^\d+(\.\d+)?/ =~ s or MAVEN_METADATA_FILE_NAME == s
      project_path += s + '/' if s != ''
    end

    config = Find.find(project_path)
    url = config.nil? ? NOT_FOUND_BASE_URL : config['url'] 
    uri = URI(url)

    host = uri.host
    port = uri.port
    path = uri.path

    env['HTTP_HOST'] = host + ':' + port.to_s unless host.nil? 
    env['PATH_INFO'] = path + env['PATH_INFO'] unless path.nil?

    return env
  end
end

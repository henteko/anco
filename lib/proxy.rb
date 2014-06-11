require 'rack-proxy'
require 'debugger'
require_relative 'model/find.rb'

class Proxy < Rack::Proxy
  def initialize(app)
    @app = app
  end

  def rewrite_env(env)
    path = env['SCRIPT_NAME'] + env['PATH_INFO']

    project_path = ''
    env['PATH_INFO'].split('/').each do |s|
      if /^\d+(\.\d+)?/ =~ s
        break
      end
      project_path += s + '/' if s != ''
    end
    pp project_path

    config = Find.find(project_path)
    return env if config.nil?

    host = config['host']
    path = config['path']

    env['HTTP_HOST'] = host unless host.nil? 
    env['PATH_INFO'] = path + env['PATH_INFO'] unless path.nil?

    return env
  end
end

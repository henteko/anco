require 'rack-proxy'
require 'debugger'

class Proxy < Rack::Proxy
  def initialize(app)
    @app = app
    @config = YAML.load_file('settings.yaml')
  end

  def rewrite_env(env)
    path = env['SCRIPT_NAME'] + env['PATH_INFO']

    array = []
    env['PATH_INFO'].split('/').each do |s|
      if /^\d+(\.\d+)?/ =~ s
        break
      end
      array.push(s) if s != ''
    end
    pp array

    tmp_config = @config;
    array.each do |key|
      tmp_config = tmp_config[key] unless tmp_config[key].nil? 
    end
    pp tmp_config['host']
    host = tmp_config['host']
    path = tmp_config['path']

    pp env

    env['HTTP_HOST'] = host unless host.nil? 
    env['PATH_INFO'] = path + env['PATH_INFO'] unless path.nil?

    return env
  end
end

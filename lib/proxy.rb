require 'rack-proxy'
require 'debugger'

class Proxy < Rack::Proxy
  def initialize(app)
    @app = app
    @config = YAML.load_file('settings.yaml')
  end

  def rewrite_env(env)
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

    tmp_config = @config;
    array.each do |key|
      tmp_config = tmp_config[key] unless tmp_config[key].nil? 
    end
    pp tmp_config['url']
    url = tmp_config['url']

    #path << "?#{env['QUERY_STRING']}" unless env['QUERY_STRING'].empty?

    env['HTTP_HOST'] = url unless url.nil? 
    env['REQUEST_URI'] = url + path unless url.nil?
    pp env
    return env
  end

  def rewrite_response(triplet)
    status, headers, body = triplet
    puts "############################"
    #headers['X-Hoge'] = 'Hoge'

    triplet
  end

end

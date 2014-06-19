require 'rack-proxy'
require 'debugger'
require './lib/model/find.rb'
require './lib/proxy_util.rb'

class Proxy < Rack::Proxy
  def initialize(app)
    @app = app
  end

  def rewrite_env(env)
    proxy_util = ProxyUtil.new(env)

    project_path = proxy_util.generate_project_path
    config = Find.find(project_path)

    return proxy_util.get_notfound_env if config.nil?

    uri = URI(config['url'])
    result_env = proxy_util.get_result_env(uri)

    result_env
  end
end

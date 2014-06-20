class ProxyUtil
  MAVEN_METADATA_FILE_NAME = 'maven-metadata.xml'

  def initialize(env)
    @env = env
    @env['SCRIPT_NAME'] = '' unless @env['SCRIPT_NAME'].nil?
  end

  def self.path_valid(path)
    return nil if /^\d+(\.\d+)?/ =~ path or MAVEN_METADATA_FILE_NAME == path

    path
  end

  def generate_project_path
    path_info = @env['PATH_INFO']

    project_path = ''
    path_info.split('/').each do |s|
      next if s == ''
      path = ProxyUtil.path_valid(s)
      break if path.nil?
      project_path += path + '/'
    end

    project_path
  end

  def get_notfound_env
    env = @env
    env['PATH_INFO'] = '/404'

    env
  end

  def get_result_env(uri)
    env = @env

    host = uri.host
    port = uri.port
    path = uri.path.gsub(/(\/)*$/, '')

    env['HTTP_HOST'] = host + ':' + port.to_s unless host.nil?
    env['PATH_INFO'] = path + env['PATH_INFO'] unless path.nil?
    env["rack.ssl_verify_none"] = true

    env
  end

  attr_accessor :env
end

require 'yaml'
require 'net/http'

class ConnectionTest

  def initialize(package_name)
    @package_name = package_name
  end

  def run
    package = @package_name.gsub(/\./, '/')
    path = 'repository/' + package + '/setting.yaml'
    return nil unless File.exist?(path)

    config = YAML.load_file(path)
    base_url = config['url']

    uri = URI(base_url + '/' + package + '/maven-metadata.xml')
    res = Net::HTTP.get_response(uri)

    return nil if res.code != '301' && res.code != '200'

    return 'Success!'
  end
end

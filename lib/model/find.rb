require 'yaml'

class Find
  BASE_PATH = 'repository/'
  SETTING_FILE_NAME = 'setting.yaml'

  def initialize
  end
  
  def self.find(path)
    setting_file_path = BASE_PATH + path + SETTING_FILE_NAME
    return nil unless File.exist?(setting_file_path)
    YAML.load_file(setting_file_path)
  end

end

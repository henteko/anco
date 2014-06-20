require './lib/proxy_util.rb'

describe ProxyUtil do
  MAVEN_METADATA_FILE_NAME = 'maven-metadata.xml'

  before do
  end

  describe "initialize" do
    it "clear SCRIPT_NAME" do
      env = {
        'SCRIPT_NAME' => 'hoge'
      }
      collect_env = {
        'SCRIPT_NAME' => ''
      }

      proxy_util = ProxyUtil.new(env)
      expect(proxy_util.env).to eq(collect_env)
    end
  end

  describe "path_valid" do
    it "basic" do
      path = 'hoge'
      result = ProxyUtil.path_valid(path)
      expect(result).to eq(path)
    end

    it "empty" do
      path = ''
      result = ProxyUtil.path_valid(path)
      expect(result).to eq(path)
    end

    it "maven metadata file name" do
      path = MAVEN_METADATA_FILE_NAME
      result = ProxyUtil.path_valid(path)
      expect(result).to be_nil
    end

    it "input int" do
      path = '6'
      result = ProxyUtil.path_valid(path)
      expect(result).to be_nil
    end

    it "input point int" do
      path = '6.0'
      result = ProxyUtil.path_valid(path)
      expect(result).to be_nil
    end

    it "input point int2" do
      path = '0.0.6'
      result = ProxyUtil.path_valid(path)
      expect(result).to be_nil
    end

    it "intput int + string" do
      path = '0.0.6hoge'
      result = ProxyUtil.path_valid(path)
      expect(result).to be_nil
    end

    it "intput string + int" do
      path = 'hoge0.0.6'
      result = ProxyUtil.path_valid(path)
      expect(result).to eq(path)
    end
  end

  describe "generate_project_path" do
    it "basic" do
      env = {
        'PATH_INFO' => '/com/example/gradle/0.0.6/gradle-0.0.6.jar'
      }
      collect = 'com/example/gradle/'

      proxy_util = ProxyUtil.new(env)

      resutl = proxy_util.generate_project_path
      expect(resutl).to eq(collect)
    end

    it "maven metadata" do
      env = {
        'PATH_INFO' => '/com/example/gradle/' + MAVEN_METADATA_FILE_NAME
      }
      collect = 'com/example/gradle/'

      proxy_util = ProxyUtil.new(env)

      resutl = proxy_util.generate_project_path
      expect(resutl).to eq(collect)
    end
  end

  describe "get_notfound_env" do
    it "basic" do
      env = {}
      collect_env = {
        'PATH_INFO' => '/404'
      }

      proxy_util = ProxyUtil.new(env)

      result_env = proxy_util.get_notfound_env
      expect(result_env).to eq(collect_env)
    end
  end

  describe "get_result_env" do
    it "basic" do
      uri = URI('http://repo1.maven.org/maven2')
      env = {
        'PATH_INFO' => '/com/example/gradle/0.0.6/gradle-0.0.6.jar'
      }
      collect_env = {
        'HTTP_HOST' => 'repo1.maven.org:80',
        'PATH_INFO' => '/maven2/com/example/gradle/0.0.6/gradle-0.0.6.jar',
        'rack.ssl_verify_none' => true
      }

      proxy_util = ProxyUtil.new(env)

      result_env = proxy_util.get_result_env(uri)
      expect(result_env).to eq(collect_env)
    end

    it "url last /" do
      uri = URI('http://repo1.maven.org/maven2/')
      env = {
        'PATH_INFO' => '/com/example/gradle/0.0.6/gradle-0.0.6.jar'
      }
      collect_env = {
        'HTTP_HOST' => 'repo1.maven.org:80',
        'PATH_INFO' => '/maven2/com/example/gradle/0.0.6/gradle-0.0.6.jar',
        'rack.ssl_verify_none' => true
      }

      proxy_util = ProxyUtil.new(env)

      result_env = proxy_util.get_result_env(uri)
      expect(result_env).to eq(collect_env)
    end

    it "url paths" do
      uri = URI('http://repo1.maven.org/maven2/repository/')
      env = {
        'PATH_INFO' => '/com/example/gradle/0.0.6/gradle-0.0.6.jar'
      }
      collect_env = {
        'HTTP_HOST' => 'repo1.maven.org:80',
        'PATH_INFO' => '/maven2/repository/com/example/gradle/0.0.6/gradle-0.0.6.jar',
        'rack.ssl_verify_none' => true
      }

      proxy_util = ProxyUtil.new(env)

      result_env = proxy_util.get_result_env(uri)
      expect(result_env).to eq(collect_env)
    end
  end
end

require './lib/proxy.rb'
require './rack/dummy_app.rb'
require './rack/not_found_app.rb'
require './rack/api_app.rb'

map '/repository' do 
  use Proxy
  run DummyApp.new
end

map '/404' do
  run NotFoundApp.new
end

map '/api' do
  run ApiApp.new
end

# static files
map '/' do
  app = Proc.new do |env|
    [301, { 'Location' => "http://#{env['HTTP_HOST']}/public/index.html" }, ['']]
  end

  run app
end

map '/public' do
  run Rack::Directory.new('./public')
end


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

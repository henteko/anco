require_relative 'lib/proxy.rb'

use Proxy
app = Proc.new do |env|
end

run app

require 'rack/request'
require 'rack/response'

class NotFoundApp
  def call(env)
    res = Rack::Response.new do |r|
      r.status = 404
      r['Content-Type'] = 'text/plain'
      r.write 'Not Found'
    end
    res.finish
  end
end

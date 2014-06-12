require 'rack/request'
require 'rack/response'

class ApiApp
  def call(env)
    req = Rack::Request.new(env)

    body = case req.request_method
           when 'GET'
             '{"hgoe": "fuga"}'
           end

    res = Rack::Response.new do |r|
      r.status = 200
      r['Content-Type'] = 'text/json'
      r.write body
    end
    res.finish
  end
end

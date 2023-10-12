require 'rack-proxy'
class Proxy < Rack::Proxy
    # def initialize(app)
    #     @app = app
    # end

    # def rewrite_env(env)
    #   env['HTTP_HOST'] = "school.tver.ru"
    #   env['PROTO'] = "http"
    #   env
    # end
end
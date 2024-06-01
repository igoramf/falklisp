require_relative './env.rb'
require_relative './main.rb'


class Procedure
    attr_accessor :parms, :body, :env

    def initialize(parms, body, env)
        @parms = parms
        @body = body
        @env = env
    end

    def call(*args)
        eval(@body, Env.new(@parms, args, @env))
    end
end

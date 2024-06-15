require_relative './env.rb'
require_relative './eval.rb'


class Procedure
    attr_accessor :params, :body, :env, :evaluator

    def initialize(params, body, env, evaluator)
        @params = params
        @body = body
        @env = env
        @evaluator = evaluator
    end

    def call(*args)
        evaluator.eval(@body, Env.new(@params, args, @env))
    end
end

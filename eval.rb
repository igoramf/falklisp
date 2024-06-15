require_relative './env.rb'
require_relative './procedure.rb'

class Eval
    def initialize(global_env)
        @global_env = global_env
    end

    def eval(x, env=global_env)
        if LispTypes.symbol?(x)  
            return env.find(x)[x]
        elsif not x.is_a?(Array)  
            return x
        elsif x[0] == "quote" 
            _, exp = x
            return exp
        elsif x[0] == "if" 
            _, test, conseq, alt = x
            exp = eval(test, env) ? conseq : alt
            return eval(exp, env)
        elsif x[0] == "define"  
            _, var, exp = x
            env[var] = eval(exp, env)
        elsif x[0] == "set!"  
            _, var, exp = x
            env.find(var)[var] = eval(exp, env)
        elsif x[0] == "lambda"  
            _, parms, body = x
            return Procedure.new(parms, body, env, self)
        else 
            proc = eval(x[0], env)
            args = x[1..-1].map { |exp| eval(exp, env) }
            return proc.call(*args)
        end
    end
end
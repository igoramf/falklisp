require_relative "./parsing/main.rb"
require_relative "./types.rb"
require_relative "./env.rb"
require_relative "./procedure.rb"
require_relative "./eval.rb"

class Main

    def call
        @global_env = standard_env
        @evaluator = Eval.new(@global_env)
        repl()
    end

    private

    attr_reader :global_env, :evaluator

    def repl(prompt='falklisp> ')
        loop do
            print prompt
            input = gets.chomp
            begin
                parsed_input = parse(input)
                val = evaluator.eval(parsed_input, global_env)
                puts lispstr(val) if val || val == false
            rescue SyntaxError => e
                puts "Syntax Error: #{e.message}"
            # rescue => e
            #     puts "Error: #{e.message}"
            end
        end
    end

    def lispstr(exp)
        if exp.is_a?(Array)
            '(' + exp.map { |e| lispstr(e) }.join(' ') + ')'
        else
            exp.to_s
        end
    end

    def parse(program)
        Parsing.new(program).call
    end

    def standard_env
        env = Env.new
        env.update({
            '+' => lambda { |x, y| x + y },
            '-' => lambda { |x, y| x - y },
            '*' => lambda { |x, y| x * y },
            '/' => lambda { |x, y| x / y.to_f },
            '>' => lambda { |x, y| x > y },
            '<' => lambda { |x, y| x < y },
            '>=' => lambda { |x, y| x >= y },
            '<=' => lambda { |x, y| x <= y },
            '=' => lambda { |x, y| x == y },
            'abs' => lambda { |x| x.abs },
            'append' => lambda { |x, y| x + y },
            'apply' => lambda { |proc, args| proc.call(*args) },
            'begin' => lambda { |*x| x[-1] },
            'car' => lambda { |x| x[0] },
            'cdr' => lambda { |x| x[1..-1] },
            'cons' => lambda { |x, y| [x] + y },
            'eq?' => lambda { |x, y| x.equal?(y) },
            'equal?' => lambda { |x, y| x == y },
            'length' => lambda { |x| x.length },
            'list' => lambda { |*x| x },
            'list?' => lambda { |x| x.is_a?(Array) },
            'map' => lambda { |proc, lst| lst.map(&proc) },
            'max' => lambda { |*x| x.max },
            'min' => lambda { |*x| x.min },
            'not' => lambda { |x| !x },
            'null?' => lambda { |x| x == [] },
            'number?' => lambda { |x| x.is_a?(Numeric) },
            'procedure?' => lambda { |x| x.respond_to?(:call) },
            'round' => lambda { |x| x.round },
            'symbol?' => lambda { |x| x.is_a?(Symbol) },
            'filter' => lambda { |proc, lst| lst.select(&proc) },
            'reduce' => lambda { |proc, init, lst| lst.reduce(init, &proc) }
        })
        env
    end

end

p = Main.new
p.call

require_relative "./tokenizer.rb"
require_relative "./read_from_tokens"

class Parsing

    def initialize(program)
        @program = program
    end

    def call
        read_from_tokens(tokenizer(program))
    end

    private

    attr_reader :program

    def read_from_tokens(tokens)
        ReadFromTokens.new(tokens).call
    end

    def tokenizer(program)
        Tokenizer.new(program).call
    end

end

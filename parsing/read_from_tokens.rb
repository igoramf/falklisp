require_relative "./atom"

class ReadFromTokens

    def initialize(tokens)
        @tokens = tokens
    end

    def call
        raise SyntaxError, 'Insert something' if tokens.empty?
        read(tokens)
    end

    private

    attr_reader :tokens


    def read(toks)
        token = toks.shift
        if token == '('
            l = []
            until toks[0] == ')'
                l << read(toks)
            end
                toks.shift # remove ')'
                return l
        elsif token == ')'
            raise SyntaxError, 'unexpected )'
        else
            return atom(token)
        end
    end

    def atom(token)
        Atom.new(token).call
    end

end
class Tokenizer

    def initialize(s)
        @s = s
    end
    
    def call
        str = s.gsub("(" ," ( ").gsub(")", " ) ").split(" ")
        raise SyntaxError, 'Missing parentheses' if !valid_parentheses(str)
        str
    end

    private 
    
    attr_reader :s

    def valid_parentheses(str)
        stack = []        
        str.each do |char|
            if char == "("
                stack.push(char)
            elsif char == ")"
                stack.pop()
            end
        end
        stack.length == 0
    end
end
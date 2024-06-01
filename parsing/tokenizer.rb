class Tokenizer

    def initialize(s)
        @s = s
    end
    
    def call
        s.gsub("(" ," ( ").gsub(")", " ) ").split(" ")
    end

    private 
    
    attr_reader :s
end
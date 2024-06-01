class Atom


    def initialize(token)
        @token = token
    end


    def call
        begin
            Integer(token)
        rescue ArgumentError
            begin
                Float(token)
            rescue ArgumentError
                token.to_sym
            end
        end
    end

    private 

    attr_reader :token

end
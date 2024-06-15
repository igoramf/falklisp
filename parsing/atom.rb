require_relative '../types.rb'

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
                token
            end
        end
    end

    private 

    attr_reader :token

end

# atom1 = Atom.new("42")
# atom2 = Atom.new("3.14")
# atom3 = Atom.new("symbol")

# puts "Atom1 #{atom1.call} Atom1.class #{atom1.call.class}"  # Deveria imprimir 42 (Integer)
# puts "Atom2 #{atom2.call} Atom2.class #{atom2.call.class}"  # Deveria imprimir 3.14 (Float)
# puts "Atom3 #{atom3.call} Atom3.class #{atom3.call.class}"  
class Env < Hash
    attr_accessor :outer

    def initialize(parms = [], args = [], outer = nil)
        self.update(Hash[parms.zip(args)])
        @outer = outer
    end

    def find(var)
        self.has_key?(var) ? self : @outer&.find(var)
    end
end


# # Exemplos de uso
# puts global_env['+'].call(1, 2)  # => 3
# puts global_env['car'].call([1, 2, 3])  # => 1
# puts global_env['cdr'].call([1, 2, 3])  # => [2, 3]

# # Testando filter e reduce
# puts global_env['filter'].call(lambda { |x| x.even? }, [1, 2, 3, 4, 5, 6]).inspect  # => [2, 4, 6]
# puts global_env['reduce'].call(lambda { |acc, x| acc + x }, 0, [1, 2, 3, 4, 5]).inspect  # => 15

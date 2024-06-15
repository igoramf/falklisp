# Definições de tipos personalizados para Lisp em Ruby
LispSymbol = String    
LispList   = Array    
LispNumber = [Integer, Float]  #

# Métodos auxiliares para verificação de tipos
module LispTypes
  def self.symbol?(obj)
    obj.is_a?(LispSymbol)
  end

  def self.list?(obj)
    obj.is_a?(LispList)
  end

  def self.number?(obj)
    LispNumber.any? { |type| obj.is_a?(type) }
  end
end
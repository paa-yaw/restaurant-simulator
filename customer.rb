class Customer
  attr_accessor :id, :age, :orders
  
  def initialize
  	@id = id_generator
  	@age  = rand(18..90)
  end

  def id_generator
    array = %w{ A B C D E F G H I J 1 2 3 4 5 6 7 8 9 0 }
    @id = []
    7.times do 
      @id << array[rand(array.size)]
    end
    @id.join("")
  end
end
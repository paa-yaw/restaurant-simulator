class Order
  attr_accessor :id, :customer, :state, :states
  
  def initialize(customer)
  	@id       = id_generator
  	@states   = ["PENDING", "COMPLETED"]
  	@state    = @states[0]
  	@customer = customer
  	@waiter   = 0
  end

  private

  def id_generator
    array = %w{ A I E O U X Y Z 1 2 3 4 5 6 7 8 9 0 }
    @id = []
    7.times do 
      @id << array[rand(array.size)]
    end
    @id.join("")
  end
end
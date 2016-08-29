require_relative "order"

class Customer
  attr_accessor :id, :age, :order, :state, :states
  
  def initialize
  	@id     = id_generator
  	@age    = rand(18..90)
    @order  = []
    @states = ["FREE", "ENGAGED"]
    @state  = @states[0]
  end

  def places_order(waiter)
    @order = Order.new(self)
    message "customer #{order.customer.id} places order..."
    message "here is my order => order id: #{@order.id} state: #{@order.state}  owner: #{@order.customer.id}"
    sleep(rand(1..3))
    waiter.takes_order(@order)
    self.state = @states[1]
  end


  private

  def id_generator
    array = %w{ A B C D E F G H I J 1 2 3 4 5 6 7 8 9 0 }
    @id = []
    7.times do 
      @id << array[rand(array.size)]
    end
    @id.join("")
  end

  def space
    puts ""
  end

  def message(message)
    puts message
  end
end
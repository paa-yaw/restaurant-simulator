require_relative "order"

class Customer
  attr_accessor :id, :age, :order, :waiter, :state, :states
  
  def initialize
  	@id     = id_generator
  	@age    = rand(18..90)
    @order  = nil
    @states = ["FREE", "ENGAGED"]
    @state  = @states[0]
    @waiter = nil
  end

  def places_order(waiter)
    self.order = Order.new(self)
    if self.state == "FREE"
      message "customer #{self.id} places order..."
      message "here is my order => order id: #{self.order.id} state: #{self.order.state}  owner: #{self.order.customer.id}"
    elsif self.state == "ENGAGED"
      message "customer #{self.id} has already been attended to by #{self.waiter.name}"        
    end
    sleep(rand(1..3))
    waiter.takes_order(@order)
    self.state = @states[1]
    message "customer ID: #{self.id}, state: #{self.state}"
    space
    space
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
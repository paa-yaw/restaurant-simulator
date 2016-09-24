require_relative "order"
require "faker"

class Customer
  attr_accessor :id, :age, :name, :order, :waiter, :state, :states, :table_no

  include Enumerable
  
  def initialize
    @name   = name_generator
  	@age    = rand(18..90)
    @order  = nil
    @states = ["FREE", "ENGAGED"]
    @state  = @states[0]
    @waiter = nil
  end

  def places_order(waiter)
    self.order = Order.new(self)
    if self.state == "FREE"
      message "#{self.name} places order..."
      message "here is my order => order id: #{self.order.id} state: #{self.order.state}  owner: #{self.order.customer.name}"
      sleep(rand(1..3))
      waiter.takes_order(@order)
      self.state = @states[1]
      # message "customer name: #{self.name}, state: #{self.state}"
    elsif self.state == "ENGAGED"
      message "customer #{self.name}: #{self.waiter.name} has already taken my order. Thank you! :)"        
    end
    space
    space
  end


  private

  def space
    puts ""
  end

  def name_generator
    (1.times.map { Faker::Name.name }).join("")
  end

  def message(message)
    puts message
  end
end
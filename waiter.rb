require_relative "order"

class Waiter
  attr_accessor :name, :age, :state, :states, :order, :orders, :tables

  def initialize(name, tables, restaurant)
  	@restaurant = restaurant
  	@tables     = tables
  	@name       = name
  	@age        = rand(18..28)
  	@states     = ["FREE", "ENGAGED"]
  	@state      = @states[0]
  	@orders     = []  	
  end

  def approaches_table
    choose_table 
    message "#{self.name} is approaching TABLE No.: #{@table.table_number}..."
    sleep(rand(1..5))
    if @table.seated_customers.size > 1
      message "hello everyone, I'm ready to take your orders. What may I offer you guys?"
    elsif @table.seated_customers.size == 1
      message "hi there, I'm ready to take your orders. What may I offer you."
    end
    @restaurant.customer_places_order(@table.seated_customers, self)
  end

  def takes_order(order)
  	sleep(rand(1..2))
  	message ""
  	message "#{self.name}: alright #{order.customer.id}, will be right back with your order
  	 Order ID: #{order.id} :)"
  	self.state = @states[1]
  end






  private

  def message(message)
  	puts message
  end

  def choose_table
  	@table = @tables[rand(@tables.size)]
  	if @table.seated_customers.size == 0
  	  choose_table
  	end
  end
end
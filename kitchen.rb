require_relative "waiter"

class Kitchen

  attr_accessor :orders, :processed_orders

  include Enumerable

  def initialize
  	@orders            = []
  	@processing_orders = []
  end

  def receives_order(order)
  	@orders << order
  end

  def processing_orders(orders)
  	@order = orders 

    while condition? do 
      randomize_order(@orders)	
      if @order.state = "PENDING"
        @order.state = @order.states[1]
        puts "#{@order.customer.name}'s order completed!"
        @processing_orders << @order if !@processing_orders.include?(@order)
      else
      	break if all_orders_processed?
      	next
      end
    end
    call_waiter
    return nil
  end

  private

  def all_orders_processed?
  	@orders.all? do |order|
  	  order.state == "COMPLETED"
  	end
  end

  def randomize_order(orders)
  	@order = orders[rand(@orders.length)]
  end

  def condition?
  	@orders.any? do |order|
  	  order.state == "PENDING"
  	end
  end

  def call_waiter
  	@processing_orders.each do |order|
  	  order.waiter.call(order)
    end
  end
end
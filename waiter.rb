require_relative "order"

class Waiter
  attr_accessor :name, :age, :state, :states, :order, :orders, :tables, :engaged_customers, :count

  include Enumerable

  def initialize(name, tables, restaurant)
    @engaged_customers = []
    @free_customers    = []
  	@restaurant        = restaurant
  	@tables            = tables
  	@name              = name
  	@age               = rand(18..28)
  	@states            = ["FREE", "ENGAGED"]
  	@state             = @states[0]
  	@orders            = []  	
    @count             = 0
  end

  def approaches_table
    choose_table 
    # message "either all customers are engaged or the remaining tables are empty" if @count == 5
    if @table.seated_customers.size > 1 && free_customers?(@table.seated_customers) && @count != 5
      message "#{self.name} is approaching TABLE No.: #{@table.table_number}..."
      sleep(rand(1..5))
      message "hello everyone, I'm ready to take your orders. What may I offer you guys?"
      @restaurant.customer_places_order(@table.seated_customers, self)
    elsif @table.seated_customers.size == 1 && free_customers?(@table.seated_customers) && @count != 5
      message "#{self.name} is approaching TABLE No.: #{@table.table_number}..." 
      sleep(rand(1..5))
      message "hi there, I'm ready to take your orders. What may I offer you."
      @restaurant.customer_places_order(@table.seated_customers, self)
    elsif @count == 5
      message "exhausted all the tables. All customers are currently engaged, and the remaining tables are empty :(" 
      @restaurant.stop_or_continue?(@count)
      space   
    elsif @table.seated_customers.empty?
      message "#{self.name} walking away because no one is here!" 
      choose_table  
    elsif (@table.seated_customers.size > 1 || @table.seated_customers.size == 1) && !free_customers?(@table.seated_customers)
      message "#{self.name} walking away because there are no free customers at TABLE NO.: #{@table.table_number}"
      # choose a table with free customers
      # abort("aborting simulation...")
      choose_table
      if free_customers?(@table.seated_customers) && (@table.seated_customers.size > 1 || @table.seated_customers.size == 1)
        message "#{self.name} walking towards TABLE NO:. #{@table.table_number}" 
      else
        choose_table
      end
    end
  end

  def takes_order(order)
  	sleep(rand(1..2))
  	message ""
    if order.customer.waiter.nil?
      order.customer.waiter = self
      message "#{self.name}: alright #{order.customer.name}, will be right back with your order
      Order ID: #{order.id} :)"
      self.state = @states[1]
      self.engaged_customers << order.customer
      # list of customers engaged by this waiter
      print "customers #{self.name} currently serving: "
      self.engaged_customers.each do |customer|
        print "#{customer.name}, "
      end
      space
    else
      if free_customers?(@restaurant.customers)
        message "#{self.name} is walking away to..."
        sleep(rand(1..3))
        @selected_customer = select_any_free_customer
        # message "#{@selected_customer.id}"
      end
    end
  end



  private

  def select_any_free_customer
    @free_customers[rand(@free_customers.size)]
  end

  def free_customers?(customers)
    customers.each do |customer|
      @free_customers << customer if customer.state == "FREE"
    end
    customers.any? do |customer|
      customer.state == "FREE"
    end
  end

  def message(message)
  	puts message
  end

  def space
    puts ""
  end

  def choose_table
  	@table = @tables[rand(@tables.size)] 
    message "#{self.name}'s checking TABLE NO.: #{@table.table_number}..."
  	if @table.seated_customers.size == 0 || !free_customers?(@table.seated_customers)
      message "TABLE NO.: #{@table.table_number} has no customers" if @table.seated_customers.empty?
      message "TABLE NO.: #{@table.table_number} has no free customers" if !free_customers?(@table.seated_customers) && @table.seated_customers.any?
  	  @tables.each do |table|
        if free_customers?(table.seated_customers) && table.seated_customers.any?
          return @table = table
          break
        else
          @count += 1
          next if table.table_number == @table.table_number
          message "checking TABLE NO.: #{table.table_number}.."
          sleep(rand(1..3))
          message "TABLE NO.: #{table.table_number} has no customers" if table.seated_customers.empty?
          message "TABLE NO.: #{table.table_number} has no free customers" if !free_customers?(table.seated_customers) && table.seated_customers.any?
          sleep(rand(1..3))
          space
          next
        end
      end
  	end
    return @count if @count == 5
  end
end
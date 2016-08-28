require_relative "customer"
require_relative "table"

class Restaurant
  attr_accessor :waiters, :customers

  include Enumerable

  def initialize
  	@waiters   = []
  	@customers = []
  	@tables    = []
  end
  
  def initiate_restaurant_activity
  	customers_enter_restaurant
  	customers_sit_and_wait
  	@tables.each do |table|
  	  puts "table number: #{table.table_number} number of customers: #{table.seated_customers.size}"
      table.seated_customers.each do |customer|
      	puts "customer id: #{customer.id}"
      end
  	end
  	puts "#{@customers.size} customers"
  end
  

  private

  def customers_sit_and_wait
  	generate_tables
  	customers_sit_across_tables
  end

  def customers_sit_across_tables
  	@randoms = []
  	@tables.each do |table|
  	  5.times do
  	    @temp = randomize_customer    
  	     table.seated_customers << @customer if !condition?(@customer)
  	  end
  	end
  end

  def randomize_customer
  	@temp = @customers[rand(@customers.size)] 
  	if check? 
  	  @temp = randomize_customer
  	  @randoms << @temp
  	  @customer = @temp		
  	else
  	  @randoms << @temp 
  	  @customer = @temp
  	end
  end

  def check?
  	@randoms.include?(@temp) 
  end

  def condition?(customer)
  	@tables.any? do |table|
  	  table.seated_customers.include?(customer)
  	end
  end

  def generate_tables
    6.times do |table_number|
      @tables << Table.new(table_number) if table_number != 0
    end	
  end

  def customers_enter_restaurant
  	generate_customers
  end
  
  def generate_customers
  	25.times do
  	  @customers << Customer.new 
  	end
  end
end
require_relative "customer"
require_relative "table"

class Restaurant
  attr_accessor :waiters, :customers

  include Enumerable

  def initialize
    @all_seated_customers = []
    @spare_tables         = []
    @randoms              = []
  	@waiters              = []
  	@customers            = []
  	@tables               = []
    @count                = 0
  end
  
  def initiate_restaurant_activity
  	customers_enter_restaurant
  	customers_sit_and_wait
  	@tables.each do |table|
      if table.seated_customers.any?
  	  puts "Table No.: #{table.table_number} number of customers: #{table.seated_customers.size}"
      table.seated_customers.each do |customer|
      	puts "customer id: #{customer.id}"
      end
      end
      puts ""
  	end
  	puts "#{@customers.size} customers"
  end
  

  private

  def customers_sit_and_wait
  	generate_tables
  	customers_sit_across_tables
  end

  def customers_sit_across_tables
  	@tables.each do |table|
  	  5.times do
  	    randomize_customer 
  	    table.seated_customers << @customer if !condition?(@customer) 
        @all_seated_customers << @customer
  	  end
  	end

    @array = remainder
    catch_remainder
  end

  def catch_remainder
    find_spare_seats
    customers_allocated_spare_seats
  end

  def customers_allocated_spare_seats
    @spare_tables.each do |table|
      if table.seated_customers.size < 5
        @array.each do |customer|
          if table.seated_customers.size < 5
            table.seated_customers << customer if !condition?(customer)
          else
            break
          end
        end
      elsif table.seated_customers.size == 5
        next
      end
    end
  end

  def find_spare_seats
    @tables.each do |table|
      if table.seated_customers.size < 5
        @spare_tables << table
      elsif table.seated_customers.size == 5
        next    
      end
    end
  end

  def remainder
    @customers - @all_seated_customers
  end

  def randomize_table
    @tables[rand(@tables.size)]
  end

  def randomize_customer
  	@customer = randomizer
  end

  def randomizer
    @customers[rand(@customers.size)] 
  end

  def check?
  	@randoms.include?(@customer) 
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
  	rand(1..25).times do
  	  @customers << Customer.new 
  	end
  end
end
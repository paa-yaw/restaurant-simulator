require_relative "customer"
require_relative "table"
require_relative "waiter"

class Restaurant
  attr_accessor :waiters, :customers

  include Enumerable

  def initialize
    @name_array           = %w{ Ruth Rachel Abigail Rose Lilian April Rebecca Jessica Priscilla }
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
    message "#{@customers.size} customers entering restaurant..."
    sleep(rand(1..10))
  	customers_sit_and_wait
    waiter_approaches_table_and_takes_order

    @engaged, @free = 0, 0
    @customers.each do |customer|
      if customer.state == "ENGAGED"
        @engaged += 1
      elsif customer.state == "FREE"
        @free += 1
      end
    end
    message "#@engaged customers engaged, #@free customers free"
  end
  
  def customer_places_order(customers, waiter)
    @random_customer = customer_randomizer(customers) 
    if @random_customer.state == "ENGAGED"
      message "this customer #{@random_customer.id} is engaged by #{@random_customer.waiter.name}, sorry"
      customer_places_order(customers, waiter)
    end
    @random_customer.places_order(waiter) if @random_customer.state == "FREE"
  end
  



  private

  def customer_randomizer(customers)
    customers[rand(customers.size)]
  end

  def waiter_approaches_table_and_takes_order
    @array_of_randomized_waiters = []
    waiter_generator    
    # print_out_waiters
    @waiters.size.times do 
      randomize_waiter
    end
    all_waiters_randomized?
    @array_of_randomized_waiters.uniq.each do |waiter|
      waiter.approaches_table
    end
    return nil
  end

  def all_waiters_randomized?
    @waiters.each do |waiter|
      @array_of_randomized_waiters << waiter if !@array_of_randomized_waiters.include?(waiter)
    end
  end

  def randomize_waiter
    @array_of_randomized_waiters << @waiters[rand(@waiters.size)]
  end

  def print_out_waiters
    @waiters.each do |waiter|
      message "name: #{waiter.name} age: #{waiter.age} state: #{waiter.state}"
      space
    end
  end

  def waiter_generator
    @name_array.each do |name|
      @waiters << Waiter.new(name, @tables, self)
    end
  end

  def customers_sit_and_wait
  	generate_tables
  	customers_sit_across_tables

    @tables.each do |table|
      if table.seated_customers.any? 
        message "**********TABLE No.: #{table.table_number}***********"  
        message "number of customers seated: #{table.seated_customers.size}"
        space
        space
        table.seated_customers.each do |customer|
          message "customer id: #{customer.id} age: #{customer.age}"
        sleep(rand(1..5))
        end
      else
        message "**********TABLE No.: #{table.table_number}***********"  
        message "number of customers seated: #{table.seated_customers.size}"
        space
        space
      end
      space
      space
    end
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
  	rand(1..5).times do
  	  @customers << Customer.new 
  	end
  end

  def space
    puts ""
  end

  def message(message)
    puts message
  end
end
require_relative "customer"

class Restaurant
  attr_accessor :waiters, :customers

  def initialize
  	@waiters   = []
  	@customers = []
  	@tables    = []
  end
  
  def initiate_restaurant_activity
  	customers_enter_restaurant
  	@customers.each do |customer|
  	  puts "id: #{customer.id} age: #{customer.age}"
  	end
  end
  

  private

  def customers_enter_restaurant
  	generate_customers
  end
  
  def generate_customers
  	25.times do
  	  @customers << Customer.new(id_generator, rand(18..90)) 
  	end
  end

  def id_generator
    array = %w{ A B C D E F G H I J 1 2 3 4 5 6 7 8 9 0 }
    @id = []
    7.times do 
      @id << array[rand(array.size)]
    end
    @id.join("")
  end
end
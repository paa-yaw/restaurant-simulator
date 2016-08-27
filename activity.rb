require_relative "restaurant"

class Activity
  
  def initialize(restaurant)
  	@restaurant = restaurant
  end

  def initiate_activity
  	@restaurant.initiate_restaurant_activity
  end
end

activity = Activity.new(Restaurant.new)
p activity.initiate_activity
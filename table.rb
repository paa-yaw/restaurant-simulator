class Table
  attr_accessor :table_number, :seated_customers
  
  def initialize(table_number)
  	@table_number     = table_number
  	@seated_customers = []
  end
end
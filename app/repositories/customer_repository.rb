require 'csv'
require 'byebug'

require_relative '../models/customer'

class CustomerRepository
  CSV_OPTIONS = {
    headers: :first_row,
    header_converters: :symbol
  }.freeze

  def initialize(filepath)
    @filepath = filepath
    # Store Customer instances
    @customers = []
    @next_id = 1
    load_csv if File.exists?(@filepath)
  end

  # READER
  def all
    @customers
  end

  def find(id)
    # Find the Customer instance the has this id
    @customers.find { |customer| customer.id == id }
  end

  # Receives a new Meal instance
  def add(customer)
    # We never handle ids directly
    # it's always the repo
    customer.id = @next_id
    @next_id += 1
    @customers << customer
    save_csv
  end

  private

  def save_csv
    CSV.open(@filepath, 'wb', CSV_OPTIONS) do |csv|
      # Write the headers
      csv << ["id", "name", "address"]

      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def load_csv

    CSV.foreach(@filepath, CSV_OPTIONS) do |row|
      # Convert strings to integers
      row[:id] = row[:id].to_i
      @customers << Customer.new(row)
    end
    # @meals.last => Meal instance
    @next_id = @customers.last.id + 1 unless @customers.empty?
  end
end

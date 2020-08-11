require 'csv'
require 'byebug'

require_relative '../models/meal'

class MealRepository
  CSV_OPTIONS = {
    headers: :first_row,
    header_converters: :symbol
  }.freeze

  def initialize(filepath)
    @filepath = filepath
    # Store Meal instances
    @meals = []
    @next_id = 1
    load_csv if File.exists?(@filepath)
  end

  # READER
  def all
    @meals
  end

  def find(id)
    # Find the Meal instance the has this id
    @meals.find { |meal| meal.id == id }
  end

  # Receives a new Meal instance
  def add(meal)
    # We never handle ids directly
    # it's always the repo
    meal.id = @next_id
    @next_id += 1
    @meals << meal
    save_csv
  end

  private

  def save_csv
    CSV.open(@filepath, 'wb', CSV_OPTIONS) do |csv|
      # Write the headers
      csv << ["id", "name", "price"]

      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv

    CSV.foreach(@filepath, CSV_OPTIONS) do |row|
      # Convert strings to integers
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      @meals << Meal.new(row)
    end
    # @meals.last => Meal instance
    @next_id = @meals.last.id + 1 unless @meals.empty?
  end
end

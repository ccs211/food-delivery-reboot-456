require 'csv'
require 'byebug'

require_relative 'base_repository'
require_relative '../models/meal'

class MealRepository < BaseRepository
  private

  def build_record(row)
    row[:id] = row[:id].to_i
    row[:price] = row[:price].to_i
    Meal.new(row)
  end

  def meals
    @elements
  end
end





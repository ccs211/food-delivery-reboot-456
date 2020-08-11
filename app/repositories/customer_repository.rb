require 'csv'
require 'byebug'

require_relative 'base_repository'
require_relative '../models/customer'

class CustomerRepository < BaseRepository
  private

  def build_record(row)
    row[:id] = row[:id].to_i
    Customer.new(row)
  end

  def customers
    @elements
  end
end





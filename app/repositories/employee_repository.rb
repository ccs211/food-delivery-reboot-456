require_relative 'base_repository'
require_relative '../models/employee'

class EmployeeRepository < BaseRepository
  undef_method :add, :create

  def all_delivery_guys
    # loop through all employees #each
    # return those that are delivery person #delivery_guy?
    # delivery_guys = []
    # employees.each do |employee|
    #   delivery_guys << employee if employee.delivery_guy?
    # end
    # delivery_guys
    # find => returns 1; non-eager
    # select => returns a subset => eager
    employees.select do |employee|
      employee.delivery_guy?
    end
  end

  def find_by_username(username)
    employees.find do |employee|
      employee.username == username
    end
  end

  private

  def employees
    @elements
  end

  # This private method is REFERENCED/CALLED in
  # BaseRepository.
  #
  # It needs to be defined here because MealRepository
  # CustomerRepository, and EmployeeRepository differ
  # in the type of elements
  # they are trying to create (Meal, Customer, and Employee)
  #
  def build_element(row)
    # Unlike the meal, there are no customer specific
    # convertions to be done on Row
    Employee.new(row) # returns an Emlpoyee instance
  end
end

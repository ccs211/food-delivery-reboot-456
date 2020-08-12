require_relative 'base_controller'
require_relative '../views/customers_view'

class CustomersController < BaseController
  def initialize(customer_repository)
    # We need to override the BaseController#initialize
    # so that we can instantiate a View which is specific
    # to this Controller.
    # We can super with the repo, so that the BaseController
    # can do the setup that is common for all controllers
    super(customer_repository)
    @view = CustomersView.new
  end

  def add
    # ask user for name
    name = @view.ask_for(:name)
    # ask user for the address
    address = @view.ask_for(:address)
    # create a customer instance
    customer = Customer.new(name: name, address: address)
    # save the meal instance
    @repository.add(customer)
  end
end

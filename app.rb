# TODO: require relevant files to bootstrap the app.
# Then you can test your program with:
#   ruby app.rb

# Require dependencies (Ruby libraries/modules)
require 'byebug'
require 'csv'

# Require all models
require_relative 'app/models/meal'
require_relative 'app/models/customer'
require_relative 'app/models/employee'
require_relative 'app/models/order'

# Require all repositories
require_relative 'app/repositories/meal_repository'
require_relative 'app/repositories/customer_repository'
require_relative 'app/repositories/employee_repository'
require_relative 'app/repositories/order_repository'

# Require all controllers
require_relative 'app/controllers/meals_controller'
require_relative 'app/controllers/customers_controller'
require_relative 'app/controllers/sessions_controller'
require_relative 'app/controllers/orders_controller'

# Require the router
require_relative 'router'

# The router needs to receive ALL of the controllers...

# In order to create a MealsController, I need to...
# have a string with the Meals CSV filepath...
meals_csv_filepath = File.join(__dir__, 'data/meals.csv')
# so that I can use it to create a MealRepository...
meal_repository = MealRepository.new(meals_csv_filepath)
# that can be used to create the MealsController:
meals_controller = MealsController.new(meal_repository)

# In order to create a CustomersController, I need to...
# have a string with the Customers CSV filepath...
customers_csv_filepath = File.join(__dir__, 'data/customers.csv')
# so that I can use it to create a CustomerRepository...
customer_repository = CustomerRepository.new(customers_csv_filepath)
# that can be used to create the CustomersController:
customers_controller = CustomersController.new(customer_repository)

# In order to create a SessionsController, I need to...
# have a string with the Employee CSV filepath...
employees_csv_filepath = File.join(__dir__, 'data/employees.csv')
# so that I can use it to create a EmployeeRepository...
employee_repository = EmployeeRepository.new(employees_csv_filepath)
# that can be used to create the SessionsController:
sessions_controller = SessionsController.new(employee_repository)

# In order to create a OrdersController, I need to...
# have a string with the Orders CSV filepath...
orders_csv_filepath = File.join(__dir__, 'data/orders.csv')
# so that I can use it to create a EmployeeRepository...
order_repository = OrderRepository.new(
  orders_csv_filepath,
  meal_repository,
  customer_repository,
  employee_repository
)
# that can be used to create the SessionsController:
orders_controller = OrdersController.new(
  meal_repository,
  customer_repository,
  employee_repository,
  order_repository
)

# Organize all controllers in a hash to be used in the Router:
controllers = {
  meals_controller: meals_controller,
  customers_controller: customers_controller,
  sessions_controller: sessions_controller,
  orders_controller: orders_controller
}

router = Router.new(controllers)

# Start the program:
router.run

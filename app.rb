# TODO: require relevant files to bootstrap the app.
# Then you can test your program with:
#   ruby app.rb

# Require dependencies
require 'byebug'

# Require router
require_relative 'router'

# Require all models
require_relative 'app/models/meal'
require_relative 'app/models/customer'

# Require all repos
require_relative 'app/repositories/meal_repository'
require_relative 'app/repositories/customer_repository'

# Require all controllers
require_relative 'app/controllers/meals_controller'

# CSV files
meal_csv_filepath = "data/meals.csv"

# Instanciate the repositories
meal_repository = MealRepository.new(meal_csv_filepath)

# Instanciate the controllers
meals_controller = MealsController.new(meal_repository)

controllers = {
  meals_controller: meals_controller
}

# Instanciate a Router
router = Router.new(controllers)

# Start the application
router.run





# TODO: implement the router of your app.
class Router
  def initialize(controllers = {})
    @meals_controller = controllers[:meals_controller]
    @running = false
  end

  def run
    @running = true

    puts "Welcome to the Food Delivery!"
    puts "           --           "

    while @running
      display_tasks
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then puts "Adding a meal"
    when 3 then puts "Listing all customer"
    when 4 then puts "Creating a customer"
    when 9 then stop
    else
      puts "Please press 1, 2, 3, 4, 5 or 6"
    end
  end

  def stop
    @running = false
  end

  def display_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all meals"
    puts "2 - Create a new  meal"
    puts "3 - List all customer"
    puts "4 - Create a new  customer"
    puts "9 - Stop and exit the program"
  end
end

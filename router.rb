# TODO: implement the router of your app.

# rubocop:disable Metrics/MethodLength
class Router
  def initialize(controllers = {})
    # Store ALL controllers in instance variables
    # so that I can use them throughout the Router
    @meals_controller = controllers[:meals_controller]
    @customers_controller = controllers[:customers_controller]
    @sessions_controller = controllers[:sessions_controller]
    @orders_controller = controllers[:orders_controller]
    @running = true
    @user = nil
  end

  # This starts the actual program:
  def run
    puts "Welcome to the Le Wagon Bistro!"
    puts "           --           "

    while @running
      # Log in
      @user = @sessions_controller.create

      # check if user exists
      while @user
        # if user Display menu based on Employee role
        @user.manager? ? display_manager_tasks : display_delivery_guy_tasks
        action = gets.chomp.to_i
        print `clear`
        @user.manager? ? route_manager_action(action) : route_delivery_guy_action(action)
      end
    end
  end

  private

  # Dispatch the User REQUEST to the
  # SPECIFIC controller action/method
  # that implements what the User wants to do
  def route_manager_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.list_undelivered_orders
    when 6 then @orders_controller.add
    when 0 then destroy_session
    when 9 then stop
    else
      puts "Please press 1, 2, 3, 4 or 9"
    end
  end

  def route_delivery_guy_action(action)
    case action
    when 1 then @orders_controller.list_my_orders(@user)
    when 2 then @orders_controller.mark_as_delivered(@user)
    when 0 then destroy_session
    when 9 then stop
    else
      puts "Please press 1, 2, or 9"
    end
  end

  def destroy_session
    @user = nil
  end

  def stop
    destroy_session
    @running = false
  end

  def display_manager_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all meals"
    puts "2 - Add a meal"
    puts "3 - List all customers"
    puts "4 - Add a customer"
    puts "5 - List all undelivered orders"
    puts "6 - Add an order"
    puts "0 - Log out"
    puts "9 - Stop and exit the program"
  end

  def display_delivery_guy_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all undelivered orders"
    puts "2 - Mark order as delivered"
    puts "0 - Log out"
    puts "9 - Stop and exit the program"
  end
end
# rubocop:enable Metrics/MethodLength

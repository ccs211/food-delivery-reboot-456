require_relative 'base_view'

class OrdersView < BaseView
  def ask_for(attribute, model)
    puts "What's the #{attribute} of the #{model}?"
    print "> "

    super(attribute)
  end
end

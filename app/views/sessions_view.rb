require 'io/console'

class SessionsView
  def ask_for_username
    puts "Username:"
    print "> "
    gets.chomp
  end

  def ask_for_password
    puts "Password:"
    print "> "
    STDIN.noecho(&:gets).chomp
  end

  def display_login_successfull(username)
    puts "Welcome, #{username}!"
  end

  def display_wrong_credentials
    puts "Wrong credentials!\n Try again!"
  end
end

require_relative '../views/sessions_view'

class SessionsController
  def initialize(repository)
    # EmployeeRepository instance
    @repository = repository
    @view = SessionsView.new
  end

  def create
    # ask for a username
    username = @view.ask_for_username
    # ask for a password
    password = @view.ask_for_password
    # find an employee with that username
    # Find returns an Employee instance or nil
    employee = @repository.find_by_username(username)
    # does the username match an employee?
    # does the password match?
    if employee && employee.password == password
       # Return an employee instance
       @view.display_login_successfull(employee.username)
       employee
    else
      @view.display_wrong_credentials
      create
    end
  end
end

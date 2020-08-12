# This Class is simply a wrapper/container to
# encapsulate SHARED code. It will never be
# initialized in our app: no BaseRepository.new

class BaseRepository
  CSV_DEFAULT_OPTIONS = {
    headers: :first_row,
    header_converters: :symbol
  }

  def initialize(csv_filepath)
    @csv_filepath = csv_filepath

    # Generic name. This Array will store either
    # Meal or Customer instances.
    @elements = []
    @next_id = 1
    load_csv if File.exist? @csv_filepath
  end

  def all
    @elements
  end

  def find(id)
    # select => []
    # This works because ALL Meal, Customer, Employee and Order
    # have a GETTER for :id, i.e.:
    #
    # Meal.new({}).id => 6
    # Customer.new({}).id => 8
    @elements.find { |element| element.id == id }
  end

  def find_by_index(index)
    @elements[index]
  end

  # receives a Meal/Customer/Employee/Order instance
  def add(element)
    # set element id
    # again, this works because BOTH Meal and Customer
    # have a SETTER for :id
    element.id = @next_id
    # push element into elements
    @elements << element
    # save changes
    save_csv
    # increment next_id
    @next_id += 1
  end
  # The tests look for a #create method. The old specs looked for #add
  # Instead of renaming the original #add method, we can alias a method
  # with the following syntax:
  alias create add
  # or, alternatively: alias_method: :create, :add

  def save
    save_csv
  end

  private

  def build_element(row)
    raise "Must implement #build_element in #{self.class}"
  end

  def load_csv
    CSV.foreach(@csv_filepath, CSV_DEFAULT_OPTIONS) do |row|
      # All Meal, Customer, Employee and Order have an :id
      # so we can deal with them in the BaseRepository
      #
      # :id needs to be converted into integer
      # name doesnt need to be converted
      row[:id] = row[:id].to_i

      # row is a Hash-like object (Duck Typing)
      # Because we need to do Meal.new, Customer.new
      # Employee.new or Order.new
      # depending on whether we are in a MealRepository
      # CustomerRepository, EmployeeRepository
      # or OrderRepository (which inherit from BaseRepository)
      # the build_element will be implemented in the
      # CHILD repositories (see MealRepository, CustomerRepository
      # EmployeeRepository and OrderRepository)
      @elements << build_element(row)
    end

    @next_id = @elements.empty? ? 1 : @elements.last.id + 1
  end

  def save_csv
    # If we are saving, for sure there must be
    # at least one element (a Meal, Customer, or Order)...
    CSV.open(@csv_filepath, 'wb') do |csv|
      # Therefore, we grab this first element from the Array
      # and get its class (it will be either Meal, Customer or Order)
      # and then use Duck Typing again to ask the class
      # what are its headers:
      #
      # (see both models for implementation)
      csv << @elements.first.class.csv_headers
      @elements.each do |element|
        # Likewise, because Meal, Customer, and Order have different
        # attributes/properties, we ask the instance to
        # convert itself into an Array
        #
        # (see the model classes for implementation)
        csv << element.to_array
      end
    end
  end
end

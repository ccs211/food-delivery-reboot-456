require 'csv'

# BaseRepository.new
class BaseRepository
  CSV_OPTIONS = {
    headers: :first_row,
    header_converters: :symbol
  }.freeze

  def initialize(filepath)
    @filepath = filepath
    # Store Customer/Meal instances
    @elements = []
    @next_id = 1
    load_csv if File.exists?(@filepath)
  end

  # READER
  def all
    @elements
  end

  def find(id)
    # Find the Customer/Meal instance the has this id
    @elements.find { |element| element.id == id }
  end

  # Receives a new Meal instance
  def add(element)
    # We never handle ids directly
    # it's always the repo
    element.id = @next_id
    @next_id += 1
    @elements << element
    save_csv
  end

  private

  def build_record(row)
    raise "Must implement #build_record"
  end

  def save_csv
    CSV.open(@filepath, 'wb', CSV_OPTIONS) do |csv|
      # Write the headers
      csv << @elements.first.class.headers

      @elements.each do |element|
        csv << element.to_csv_row
      end
    end
  end

  def load_csv

    CSV.foreach(@filepath, CSV_OPTIONS) do |row|
      # Convert strings to integers
      @elements << build_record(row)
    end
    # @meals.last => Meal instance
    @next_id = @elements.last.id + 1 unless @elements.empty?
  end
end






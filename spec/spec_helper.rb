require "date"

module SpecHelper
  def load_fixture(file_name)
    path = File.dirname(__FILE__)
    fixture_path = File.join(path, "fixtures", file_name)
    File.read(fixture_path)
  end

  def parse_date(str)
    Date.strptime(str, '%m/%d/%Y')
  end

  def Person(last_name, first_name, gender, favorite_color, date_of_birth)
    Person.new last_name:      last_name,
               first_name:     first_name,
               gender:         gender,
               favorite_color: favorite_color,
               date_of_birth:  date_of_birth
  end
end

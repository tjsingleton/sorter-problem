require "date"
require "csv"

require_relative "person"

module PersonListParser
  def self.parse(input, format)
    parser_for(format).parse(input)
  end

  def self.parser_for(format)
    const_get format.to_s.upcase
  end

  class CSV
    HEADERS = [:last_name, :first_name, :gender, :favorite_color, :date_of_birth]

    def self.parse(input)
      new(input).parse
    end

    def initialize(input)
      @input = input
    end

    def parse
      rows = []

      ::CSV.parse(@input, headers: HEADERS) do |row|
        rows << row_to_person(row)
      end

      rows
    end

    private
    def row_to_person(row)
      row.each{|k, v| v.strip! }
      row[:date_of_birth] = Date.strptime(row.field(:date_of_birth), '%m/%d/%Y')
      Person.new row.to_hash
    end
  end
end

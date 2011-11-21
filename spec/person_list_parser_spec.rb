require_relative "spec_helper"
require_relative "../lib/person_list_parser"

describe PersonListParser do
  it "returns a parser for the format" do
    parser = PersonListParser.parser_for(:csv)
    parser.should == PersonListParser::CSV
  end

  it "provides a facade to the format parser" do
    input = double

    PersonListParser::CSV.should_receive(:parse).with(input)

    PersonListParser.parse(input, :csv)
  end
end

describe PersonListParser::CSV do
  include SpecHelper

  let(:input) { load_fixture('comma.txt') }
  let(:parser) { PersonListParser::CSV.new(input) }

  it "generates an array of persons" do
    parser.parse.should == [
        Person("Abercrombie", "Neil",    "Male",   "Tan",    parse_date("2/13/1943")),
        Person("Bishop",      "Timothy", "Male",   "Yellow", parse_date("4/23/1967")),
        Person("Kelly",       "Sue",     "Female", "Pink",   parse_date("7/12/1959"))
    ]
  end
end

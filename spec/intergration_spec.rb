require_relative "spec_helper"
require_relative "../lib/sorted_person_list"

describe "CSV input" do
  include SpecHelper

  let(:input) { load_fixture('comma.txt') }

  let(:row_1) { Person "Abercrombie", "Neil",    "Male",   "Tan",    parse_date("2/13/1943")  }
  let(:row_2) { Person "Bishop",      "Timothy", "Male",   "Yellow", parse_date("4/23/1967") }
  let(:row_3) { Person "Kelly",       "Sue",     "Female", "Pink",   parse_date("7/12/1959") }

  def sorter(sort)
    SortedPersonList.from_string(input, sort: sort)
  end

  it "can be sorted last name desc" do
    sorter(:last_name_desc).to_a.should == [ row_3, row_2, row_1 ]
  end

  it "can be sorted gender, last name asc" do
    sorter(:gender_last_name).to_a.should == [ row_3, row_1, row_2 ]
  end

  it "can be sorted date, last name" do
    sorter(:date_last_name).to_a.should == [ row_1, row_3, row_2 ]
  end
end

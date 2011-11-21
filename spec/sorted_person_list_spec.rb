require_relative "../lib/sorted_person_list"

describe SortedPersonList do
  it "parses the input and adds people to the list" do
    input   = double
    person  = double
    list    = double
    sorter  = SortedPersonList::SORTS[:last_name_desc]

    PersonListParser.should_receive(:parse).with(input, :csv).and_return [person]
    SortedList.should_receive(:new).with(sorter).and_return list
    list.should_receive(:add).with(person)

    SortedPersonList.from_string(input, format: :csv, sort: :last_name_desc)
  end
end

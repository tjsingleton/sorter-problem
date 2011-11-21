require_relative "../lib/composite_sorter"

describe CompositeSorter do
  let(:input) { [{test: 2, foo: 'b'}, {test: 1, foo: 'c'}, {test: 2, foo: 'a'}] }

  let(:sorter) { CompositeSorter.new }

  let(:sorted) { input.sort(&sorter) }

  it "sort by two fields" do
    sorter.add {|a, b| b[:test] <=> a[:test] }
    sorter.add {|a, b| a[:foo]  <=> b[:foo] }

    sorted.should == [{test: 2, foo: 'a'}, {test: 2, foo: 'b'}, {test: 1, foo: 'c'}]
  end

  it "sort by is by order added" do
    sorter.add {|a, b| a[:test] <=> b[:test] }
    sorter.add {|a, b| b[:foo]  <=> a[:foo] }

    sorted.should == [{test: 1, foo: 'c'}, {test: 2, foo: 'b'}, {test: 2, foo: 'a'}]
  end
end

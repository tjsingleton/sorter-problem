require_relative "../lib/sorter"

describe Sorter do
  let(:input) { [{test: 3}, {test: 1}, {test: 2}] }

  def sorted(dir = :asc)
    sorter = Sorter.new(:test, direction: dir)
    input.sort(&sorter).map{|h| h[:test] }
  end

  it "generates an asc sort" do
    sorted.should == [1,2,3]
  end

  it "generates a desc sort" do
    sorted(:desc).should == [3,2,1]
  end
end

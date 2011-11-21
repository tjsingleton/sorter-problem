class SortedList
  def initialize(sorter)
    @sorter = sorter
    @list   = []
  end

  def add(person)
    @list << person
    @list.sort! &@sorter
  end

  def to_a
    @list.dup
  end

  def ==(other)
    to_a == other.to_a
  end
end

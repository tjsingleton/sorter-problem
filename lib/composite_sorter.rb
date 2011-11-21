class CompositeSorter
  def initialize
    @sorters = []
  end

  def add(&block)
    @sorters << block
  end

  def to_proc
    ->(a, b){ sort(a, b) }
  end

  private
  def sort(a, b)
    result = 0

    @sorters.each do |sorter|
      result = sorter[a, b]
      break unless result == 0
    end

    result
  end
end

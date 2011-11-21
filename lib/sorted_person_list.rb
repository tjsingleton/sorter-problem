class SortedPersonList
  SORTS = {}

  DEFAULT_FORMAT = :csv
  DEFAULT_SORT   = :last_name_desc

  def self.add_sort(label, &block)
    sorter = CompositeSorter.new
    block.call(sorter)

    SORTS[label] = sorter.to_proc
  end

  def self.from_string(input, options = {})
    format = options.fetch(:format) { DEFAULT_FORMAT }
    sort   = options.fetch(:sort) { DEFAULT_SORT }
    sorter = SORTS[sort]
    list   = new(sorter)

    PersonListParser.parse(input, format).each do |person|
      list.add person
    end

    list
  end

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

  class Sorter
    DEFAULT_DIRECTION = :asc

    def initialize(field, options = {})
      @direction = options.fetch(:direction) { DEFAULT_DIRECTION }
      @field     = field
    end

    def to_proc
      @direction == :asc ?
          ->(a, b){ sort(a, b) } :
          ->(a, b){ sort(b, a) }
    end

    private
    def sort(a, b)
      a.send(@field) <=> b.send(@field)
    end
  end

  add_sort :last_name_desc do |sorter|
    sorter.add &Sorter.new(:last_name, direction: :desc)
  end

  add_sort :gender_last_name do |sorter|
    sorter.add &Sorter.new(:gender)
    sorter.add &Sorter.new(:last_name)
  end

  add_sort :date_last_name do |sorter|
    sorter.add &Sorter.new(:date_of_birth)
    sorter.add &Sorter.new(:last_name)
  end


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

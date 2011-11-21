class SortedPersonList
  SORTS = {}

  DEFAULT_FORMAT = :csv
  DEFAULT_SORT   = :last_name_desc

  def self.add_sort(label, &block)
    SORTS[label] = block
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

  class Sorter
    DEFAULT_DIRECTION = :asc

    def initialize(*args)
      options    = args.last.kind_of?(Hash) ? args.pop : {}
      @direction = options.fetch(:direction) { DEFAULT_DIRECTION }
      @fields    = args
    end

    def to_proc
      @direction == :asc ?  asc_sort : desc_sort
    end

    private
    def asc_sort
      ->(a,b) { select_fields(a) <=> select_fields(b) }
    end

    def desc_sort
      ->(a,b) { select_fields(b) <=> select_fields(a) }
    end

    def select_fields(obj)
      @fields.map {|n| obj.send(n) }
    end
  end

  add_sort :last_name_desc,   &Sorter.new(:last_name, direction: :desc)
  add_sort :gender_last_name, &Sorter.new(:gender, :last_name)
  add_sort :date_last_name,   &Sorter.new(:date_of_birth, :last_name)

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

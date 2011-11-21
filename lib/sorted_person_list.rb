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

  add_sort(:last_name_desc) {|a,b| b.last_name <=> a.last_name }
  add_sort(:gender_last_name) {|a,b| [a.gender, a.last_name] <=> [b.gender, b.last_name] }
  add_sort(:date_last_name) {|a,b| [a.date_of_birth, a.last_name] <=> [b.date_of_birth, b.last_name] }

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

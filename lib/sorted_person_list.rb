require_relative "sorted_list"
require_relative "composite_sorter"
require_relative "sorter"

module SortedPersonList
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
    list   = SortedList.new(sorter)

    PersonListParser.parse(input, format).each do |person|
      list.add person
    end

    list
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
end


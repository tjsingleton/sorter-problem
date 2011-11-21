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
    a[@field] <=> b[@field]
  end
end

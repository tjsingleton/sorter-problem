class Person
  attr_reader :last_name, :first_name, :gender, :favorite_color, :date_of_birth

  def initialize(attrs = {})
    @first_name     = attrs.fetch(:first_name)
    @last_name      = attrs.fetch(:last_name)
    @gender         = attrs.fetch(:gender)
    @favorite_color = attrs.fetch(:favorite_color)
    @date_of_birth  = attrs.fetch(:date_of_birth)
  end

  def to_a
    [@first_name, @last_name, @gender, @favorite_color, @date_of_birth]
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end

  def ==(other)
    to_a == other.to_a
  end
end

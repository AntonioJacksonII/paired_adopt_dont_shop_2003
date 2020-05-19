class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = [initial_contents].compact.flatten || Array.new()
  end


  def total_count
    @contents.count
  end

  def add_pet(pet)
    @contents << pet
  end


end

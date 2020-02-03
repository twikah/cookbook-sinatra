class Recipe
  attr_accessor :name, :description, :prep_time, :difficulty, :done
  def initialize(name, description, prep_time, difficulty, done = false)
    @name = name
    @description = description
    @prep_time = prep_time
    @done = done
    @difficulty = difficulty
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end

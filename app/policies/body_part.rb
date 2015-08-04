class BodyPart
  attr_reader :id, :name, :variable_name
  def initialize(id, name, variable_name)
    @id = id
    @name = name
    @variable_name = variable_name
  end
end


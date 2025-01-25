class ProjectDecorator
  def initialize(project)
    @project = project
  end

  def self.column_names_rus
    {
      "title" => "Название",
      "description" => "Описание"
    }
  end

  def value_for(attr)
    case attr
    when "title"
      @project.title
    when "description"
      @project.description
    else
      nil
    end
  end

  private

  attr_reader :project
end
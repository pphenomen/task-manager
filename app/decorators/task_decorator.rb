class TaskDecorator

  STATUS_HASH = {
    'новая' => 'Новая',
    'в_процессе' => 'В процессе',
    'завершена' => 'Завершена'
  }.freeze

  def initialize(task)
    @task = task
  end

  def formatted_due_date
    @task.due_date.strftime('%d.%m.%Y') if @task.due_date.present?
  end

  def project_name
    @task.project.present? ? @task.project.title : 'Без проекта'
  end

  def assignee_name
    @task.assignee.present? ? @task.assignee.name : 'Без исполнителя'
  end

  def value_for(attr)
    case attr
    when "due_date"
      formatted_due_date
    when "project_id"
      project_name
    when "assignee_id"
      assignee_name
    when "status"
      current_status
    else
      nil
    end
  end

  def current_status
    {
      'новая' => 'Новая',
      'в_процессе' => 'В процессе',
      'завершена' => 'Завершена'
    }[@task.status] || @task.status
  end

  def self.status_options
    STATUS_HASH.map { |key, value| [value, key] }
  end

  def self.column_names_rus
    {
      'title' => 'Название',
      'description' => 'Описание',
      'due_date' => 'Срок выполнения',
      'status' => 'Статус',
      'project_id' => 'Проект',
      'assignee_id' => 'Исполнитель'
    }
  end

  private

  attr_reader :task
end

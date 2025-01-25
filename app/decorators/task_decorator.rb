class TaskDecorator < BaseDecorator

  STATUS_HASH = {
    'новая' => 'Новая',
    'в_процессе' => 'В процессе',
    'завершена' => 'Завершена'
  }.freeze

  def formatted_due_date
    object.due_date&.strftime('%d.%m.%Y')
  end

  def project_name
    object.project&.title || 'Без проекта'
  end

  def assignee_name
    object.assignee&.name || 'Без исполнителя'
  end

  def current_status
    STATUS_HASH[object.status] || object.status
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
end

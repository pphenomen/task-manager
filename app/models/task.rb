class Task < ApplicationRecord
  belongs_to :project
  belongs_to :assignee, class_name: 'User'

  validates :title, presence: true
  validates :status, inclusion: { in: %w[новая в_процессе завершена] }

  def self.column_names_rus
    {
      "title" => "Название",
      "description" => "Описание",
      "due_date" => "Срок выполнения",
      "status" => "Статус",
      "project_id" => "Проект",
      "assignee_id" => "Исполнитель"
    }
  end

  def project_name
    project.present? ? project.title : "Без проекта"
  end

  def assignee_name
    assignee.present? ? assignee.name : "Без исполнителя"
  end

  def current_status
    status_hash = { 'Новая' => 'новая', 'В процессе' => 'в_процессе', 'Завершена' => 'завершена' }
    status_hash[status]
  end

  def formatted_due_date
    due_date.strftime("%d.%m.%Y") if due_date.present?
  end
end

class Task < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :assignee, class_name: 'User', optional: true

  validates :title, 
            presence: { message: "Название задачи не может быть пустым" },
            length: { 
              minimum: 3, 
              maximum: 255, 
              message: "Название задачи должно быть от 3 до 255 символов" 
            }
  validates :description, 
            length: { 
              maximum: 500, 
              message: "Описание задачи не должно превышать 500 символов" 
            }

  validates :status,
            presence: { message: "Статус должен быть выбран" }

  validates :project_id, 
            presence: { message: "Проект должен быть выбран" }

  validates :assignee_id, 
            presence: { message: "Исполнитель должен быть выбран" }

  validates :due_date, 
            presence: { message: "Срок выполнения должен быть выбран" }
  validate :due_date_cannot_be_in_the_past

  STATUS_HASH = {
    'новая' => 'Новая',
    'в_процессе' => 'В процессе',
    'завершена' => 'Завершена'
  }.freeze

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
    STATUS_HASH[status] || status
  end

  def self.status_options
    STATUS_HASH.map { |key, value| [value, key] }
  end

  def formatted_due_date
    due_date.strftime("%d.%m.%Y") if due_date.present?
  end

  private

  def due_date_cannot_be_in_the_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "Срок выполнения не может быть в прошлом")
    end
  end
end

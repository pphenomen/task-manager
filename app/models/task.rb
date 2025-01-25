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

  private

  def due_date_cannot_be_in_the_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "Срок выполнения не может быть в прошлом")
    end
  end
end

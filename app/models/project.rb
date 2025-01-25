class Project < ApplicationRecord
  has_many :tasks, dependent: :restrict_with_error

  validates :title, 
            presence: { message: "Название проекта не может быть пустым" },  
            uniqueness: { message: "Название проекта уже используется" }
  validates :description, 
            length: { 
              maximum: 500, 
              message: "Описание проекта не должно превышать 500 символов" 
            }

  def active_tasks
    tasks.where(status: "в_работе")
  end
end

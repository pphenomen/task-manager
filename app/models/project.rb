class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :title, 
            presence: { message: "Название проекта не может быть пустым" },  
            uniqueness: { message: "Название проекта уже используется" }
  validates :description, 
            length: { 
              maximum: 500, 
              message: "Описание проекта не должно превышать 500 символов" 
            }

  def self.column_names_rus
    {
      "title" => "Название",
      "description" => "Описание"
    }
  end

  def active_tasks
    tasks.where(status: "в_работе")
  end
end

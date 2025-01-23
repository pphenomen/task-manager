class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :description, length: { maximum: 500 }

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

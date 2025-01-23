class User < ApplicationRecord
	has_many :tasks, foreign_key: "assignee_id"

  	validates :name, presence: true
  	validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
	
  	def self.column_names_rus
  	  {
  	    "name" => "Имя",
  	    "email" => "Электронная почта"
  	  }
  	end
end

class User < ApplicationRecord
	has_many :tasks, foreign_key: "assignee_id"

  	validates :name, 
  		presence: { message: "Имя не может быть пустым" }, 
  		format: { with: /\A[а-яА-ЯёЁa-zA-Z]+\z/, message: "Имя может содержать только буквы" }
  	validates :email, 
  		presence: { message: "Электронная почта не может быть пустой" }, 
  		uniqueness: { message: "Электронная почта уже используется" }, 
  		format: { with: URI::MailTo::EMAIL_REGEXP, message: "Электронная почта не соответствует формату: username@example.com" }

  	def self.column_names_rus
  	  {
  	    "name" => "Имя",
  	    "email" => "Электронная почта"
  	  }
  	end
end

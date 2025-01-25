class UserDecorator
	def initialize(user)
		@user = user
	end

	def self.column_names_rus
  	{
  	  "name" => "Имя",
  	  "email" => "Электронная почта"
  	}
  end

  def value_for(attr)
    case attr
    when "name"
      @user.name
    when "email"
      @user.email
    else
      nil
    end
  end

	private

	attr_reader :user
end
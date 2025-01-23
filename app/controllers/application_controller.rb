class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def self.column_names
    raise NotImplementedError, "Метод column_names должен быть реализован в подклассах"
  end
end

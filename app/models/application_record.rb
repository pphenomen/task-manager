class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.human_attribute_name(attribute, options = {})
    ""
  end

  def self.column_names_rus
    raise NotImplementedError, "Метод column_names_rus должен быть реализован в подклассах"
  end
end

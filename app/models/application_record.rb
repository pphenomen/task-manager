class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.human_attribute_name(attribute, options = {})
    ""
  end
end

class Task < ApplicationRecord
  belongs_to :project
  belongs_to :assignee, class_name: 'User'
end

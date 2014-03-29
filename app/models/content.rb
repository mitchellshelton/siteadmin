class Content < ActiveRecord::Base

  # basic validations
  validates :title, presence: true
  validates :body, presence: true

end

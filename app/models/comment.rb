class Comment < ApplicationRecord
  # associations
  belongs_to :post

  # validations
  validates_presence_of :body

end

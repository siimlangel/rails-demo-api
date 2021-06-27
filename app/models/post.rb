class Post < ApplicationRecord
    # associations
    has_many :comments, dependent: :destroy

    #  validations
    validates_presence_of :title, :body
end

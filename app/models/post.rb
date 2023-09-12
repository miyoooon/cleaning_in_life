class Post < ApplicationRecord
  belongs_to :user
  belongs_to :tag, optional: true

  validates :title, presence: true
  validates :text, presence: true

end

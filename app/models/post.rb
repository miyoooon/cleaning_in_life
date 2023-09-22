class Post < ApplicationRecord
  belongs_to :user
  belongs_to :tag, optional: true

  validates :title, presence: true
  validates :text, presence: true

   def self.looks(keyword)
    if keyword.present?
      where("title LIKE ? OR text LIKE ?", "%#{keyword}%", "%#{keyword}%")
    else
      all
    end
  end
end

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :tag, optional: true
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  validates :title, presence: true
  validates :text, presence: true

  def self.looks(keyword)
    if keyword.present?
      where("title LIKE ? OR text LIKE ?", "%#{keyword}%", "%#{keyword}%")
    else
      all
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end

class Article < ApplicationRecord
  belongs_to :user

  validates :title, :content, :user_id, presence: true

  validates_uniqueness_of :title, scope: [:user_id]
end
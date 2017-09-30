class Tag < ApplicationRecord
  belongs_to :article

  with_options class_name: 'Tag', foreign_key: :parent_id do |a|
    a.has_many :sub_tags, dependent: :destroy
  end

  TAG_PARENT_ID = 0

  validates :article_id, :name, :parent_id, presence: true
  # Only one uniq name is allowed to create as a tag and for tag's sub_tags, per article.
  validates_uniqueness_of :name, scope: [:parent_id, :article_id]

  validate :tag_name

  private
  def tag_name
    # This will replace all non chars and non numbers with '-'. Then strips last n '-' chars.
    # Ex: 'hi %5:-)' => 'hi--5'
    sanitized_name = self.name.gsub(/[^\w]/, '-').gsub(/-+$/,'')

    if sanitized_name.blank?
      raise IOError, 'Tag / Sub tags names should start with an alphabet or a number'
    end

    self.name = sanitized_name
  end
end

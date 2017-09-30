class Article < ApplicationRecord
  belongs_to :user

  has_many :tags, -> { where(parent_id: Tag::TAG_PARENT_ID) }

  validates :title, :content, :user_id, presence: true

  validates_uniqueness_of :title, scope: [:user_id]

  # Create articles. Create tags / subtags and links with the article.
  def self.save_article(create_params)
    article = nil

    Article.transaction do
      tags = create_params.delete(:tags)
      # Create article
      article = Article.create!(create_params.delete_if{|k, v| 'tags' == k })

      if tags.present?
        tags.each do |index, tag_sub_tags_hash|
          # Create tag
          tag = article.tags.create!(name: tag_sub_tags_hash[:name])

          # Create Subtags
          if tag_sub_tags_hash[:sub_tags].present?
            tag_sub_tags_hash[:sub_tags].uniq.each do |sub_tag_name|
              tag.sub_tags.create!(name: sub_tag_name, parent_id: tag.id, article_id: article.id)
            end
          end
        end
      end
    end

    article
  end

  def self.perform_search_and_get_results(query)
    # Search in Article's name or content
    result_ids = Article.where('title like ? or content like ?', "%#{query}%", "%#{query}%").pluck(:id)

    # Search in Tag's name, since sub tags are children of tags.
    result_ids += Tag.where('name like ?', "%#{query}%").pluck(:article_id)

    Article.where(id: result_ids)
  end
end

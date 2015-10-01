class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, presence: true
  validates :body, presence: true

  def all_tags
    tags.map{|tag| tag.text }.join(",")
  end

  def all_tags=(tag_list)
    form_tags = tag_list.split(",")

    # delete tags no longer in list
    self.tags.each {|tag| self.tags.delete(tag) unless form_tags.include?(tag.text) }

    # find tags that already exist in db that user entered
    existing_form_tags = Tag.where("text IN (?)", form_tags)

    # find existing tags that need to be associated with this post
    new_existing_form_tags = existing_form_tags.select{|tag| !self.tags.include?(tag) }
    self.tags << new_existing_form_tags

    # find form tags that need to be created in the db
    existing_form_tags_text = existing_form_tags.map {|tag| tag.text }
    new_tags = form_tags.reject{|tag| existing_form_tags_text.include?(tag) }

    # add tag to the collection (build will instantiate, but not save)
    new_tags.each { |tag| self.tags.build(text: tag) }
  end
end


# need to add harrison in new_tags
# need to associate pair from existing tags

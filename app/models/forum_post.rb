class ForumPost < ActiveRecord::Base
  belongs_to :forum_cat_l2
  has_many :forum_replies, :dependent => :destroy
  belongs_to :user
  validates_presence_of :title
  validates_presence_of :comment

  after_create { |forum_post| update_last_post(forum_post) }
  after_update { |forum_post| update_last_post(forum_post) }
  
  def self.update_last_post(forum_post)
    @forum_cat_l2 = ForumCatL2.find(forum_post.forum_cat_l2_id)
    @forum_cat_l2.last_post_id = forum_post.id
    @forum_cat_l2.save!    
  end

  def to_param
    (title ? title.parameterize : '' ) << "-" << id.to_s
  end

end

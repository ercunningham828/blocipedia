class Wiki < ActiveRecord::Base
  belongs_to :user

  default_scope { order('created_at DESC') }

  scope :visible_to, -> (user) { user ? (user.role=="admin" ? all: ((publicly_viewable + where(user_id: user.id)).sort_by &:created_at).reverse) : publicly_viewable }
  scope :publicly_viewable, -> {where(private: false)}
  scope :privately_viewable, -> {where(private: true)}


end

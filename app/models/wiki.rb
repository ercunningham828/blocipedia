class Wiki < ActiveRecord::Base
  belongs_to :user

  default_scope { order('created_at DESC') }
  scope :visible_to, -> (user) { user ? all : publicly_viewable}
  scope :publicly_viewable, -> {where(private: false)}
  scope :privately_viewable, -> {where(private: true)}
end

class Wiki < ActiveRecord::Base
  has_many :collaborations
  has_many :users, through: :collaborations

  default_scope { order('created_at DESC') }
end

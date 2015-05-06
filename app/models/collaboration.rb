class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki

  def user_name
    user.name
  end
end

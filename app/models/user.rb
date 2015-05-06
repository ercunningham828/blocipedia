class User < ActiveRecord::Base
  has_many :collaborations
  has_many :wikis, through: :collaborations
  
  after_initialize :set_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
def admin?
   role == 'admin'
 end
 
 def premium?
   role == 'premium'
 end

 def set_role
  self.role ||= "standard"
 end

end

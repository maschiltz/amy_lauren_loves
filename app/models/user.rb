class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  # removed :registerable, :recoverable
  devise :database_authenticatable,
         :rememberable, :trackable, :validatable
end

class User < ActiveRecord::Base
  ROLES = %w[admin moderator author]

  has_and_belongs_to_many :blogs, :class_name=> 'Yuzublog::Blog'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmmable, :lockable and :timeoutable
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :family_name, :given_name, :display_name

 def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
  data = access_token['extra']['user_hash']
  if user = User.find_by_email(data["email"])
    user
  else # Create an user with a stub password. 
    User.create!(:email => data["email"], :password => Devise.friendly_token[0,20]) 
  end
 end 
 
 def self.new_with_session(params, session)
   super.tap do |user|
     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
       user.email = data["email"]
     end
   end
 end
 
end

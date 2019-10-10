class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

 has_many :identities, dependent: :destroy
 has_many :alba_favs, dependent: :destroy
  def self.find_for_oauth(auth, signed_in_resource = nil)
    # user와 identity가 nil이 아니라면 받는다
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user
    
    # user가 nil이라면 새로 만든다.
    if user.nil?
      if auth.provider == "kakao"
        email = "#{auth.uid}@#{auth.provider}.com"
        user = User.where(:email => email).first
        
        unless self.where(email: auth.info.email).exists?
        
          if user.nil?
              user = User.new(
              name: auth.info.name,
              email:"#{auth.uid}@#{auth.provider}.com",
              provider: auth.provider,
              profileImg: auth.info.image,
              password: Devise.friendly_token[0,20]
            )
            user.save
          end
        end
      else
        email = auth.info.email
        user = User.where(:email => email).first  
        unless self.where(email: auth.info.email).exists?
          # 없다면 새로운 데이터를 생성한다.
          if user.nil?
            user = User.new(
              email: email ? auth.info.email : "#{auth.uid}@#{auth.provider}.com",
              provider: auth.provider,
              profileImg: auth.info.image,
              password: Devise.friendly_token[0,20]
            )            
            user.save!
          end
        end
      end      # 이미 있는 이메일인지 확인한다.
    end
    
    if identity.user != user
      identity.user = user
      identity.uid = (0...8).map { (65 + rand(26)).chr }.join
      identity.save!
    end
    user
    
  end
  
  def email_required?
    false
  end
 
  def email_changed?
    false
  end
end
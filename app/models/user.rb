class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
             format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  validates :password, length: { minimum: 6 }
  has_secure_password
  has_many :tasks, , dependent: :destroy
  before_destroy: last_one_admin
  before_update: last_one_admin

  private

  def last_one_admin
    if User.find(id).admin
      throw(:abord) if (User.where(admin:true).count - [self].count == 0)
    end
  end

end
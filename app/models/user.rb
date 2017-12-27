class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  validates :name, presence: true
  validates :email, presence: true, format: /\A\S+@\S+\z/, uniqueness: { case_sensitive: false}
  validates :password, length: { minimum: 10, allow_blank: true }
  validates :username, presence: true, uniqueness: {case_sensitive: false}, format: /\A[A-Z0-9]+\z/i

  scope :by_name, -> {order(name: :desc)}
  scope :non_admins, -> {by_name.where(admin: false)}

def self.authenticate(signin, password)
	user_email = User.find_by(email: signin)
	user_username = User.find_by(username: signin)
	(user_email && user_email.authenticate(password)) || (user_username && user_username.authenticate(password))
end
end

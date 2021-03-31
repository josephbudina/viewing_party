class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :parties

  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :password, confirmation: true

  enum role: %w(regular admin)

  def invites
    # current_user != user.id
    # id = self.id
    # Party.joins(:party_friends).where(party_friends: {friendship_id: self.id})
    PartyFriend.find_invited_parties(self.id)
  end

  def self.sanitize_email
    email.downcase
  end
end

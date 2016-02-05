# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  user_avatar            :string           default("")
#  name                   :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  before_save :prepare_params

  has_many :portfolios, dependent: :destroy
  has_many :stocks,     dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name,  presence: true

  devise :database_authenticatable,
         :confirmable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  mount_uploader :user_avatar, UserAvatarUploader

  def has_stock?(symbol, portfolio_id)
    stocks.exists?(symbol: symbol, portfolio_id: portfolio_id)
  end

  def has_portfolio?(portfolio_id)
    portfolios.exists?(id: portfolio_id)
  end

  def prepare_params
    self.email = self.email.downcase
  end
end

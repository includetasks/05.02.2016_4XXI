# == Schema Information
#
# Table name: portfolios
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :stocks, dependent: :destroy

  validates :title, presence: true

  def stock_list
    stocks.inject([]) do |m, v|
      m << v.symbol
    end
  end

  def stock_count
    stocks.inject(0) do |m, v|
      m + v.count
    end
  end
end

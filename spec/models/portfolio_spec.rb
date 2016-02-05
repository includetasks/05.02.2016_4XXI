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

require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  let(:spec_portfolio) do
    spec_user = create(:user)
    portfolio = spec_user.portfolios.create(
      attributes_for(:portfolio)
    )

    spec_user.stocks.create(
      attributes_for(:stock).merge(portfolio: portfolio)
    )

    spec_user.stocks.create(
      attributes_for(:another_stock).merge(portfolio: portfolio)
    )

    portfolio
  end

  context 'is valid when' do
    it 'all fields has allowable values' do
      expect(spec_portfolio).to be_valid
    end
  end

  context 'is invalid when' do
    it '#title is not present' do
      spec_portfolio.title = ''
      expect(spec_portfolio).not_to be_valid
    end
  end

  it '#stock_list returns stocks symbols in array form' do
    symbols = [
      attributes_for(:stock)[:symbol],
      attributes_for(:another_stock)[:symbol]
    ]

    expect(spec_portfolio.stock_list).to eq(symbols)
  end

  it '#stock_count retunrs the entire amount of symbols' do
    count = attributes_for(:stock)[:count] +
            attributes_for(:another_stock)[:count]

    expect(spec_portfolio.stock_count).to eq(count)
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:stocks).dependent(:destroy) }
  end
end

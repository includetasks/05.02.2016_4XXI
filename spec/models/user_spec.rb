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

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:spec_user) do
    spec_user = create(:user)
    portfolio = spec_user.portfolios.create(
      attributes_for(:portfolio)
    )

    spec_user.stocks.create(
      symbol: attributes_for(:stock)[:symbol],
      portfolio: portfolio
    )

    spec_user
  end

  let(:spec_another_user) { create(:user) }

  context 'is valid when' do
    it 'all fields has allowable values' do
      expect(spec_user).to be_valid
    end
  end

  context 'is invalid when' do
    it '#name is not present' do
      spec_user.name = ''
      expect(spec_user).not_to be_valid
    end

    it '#email is not present' do
      spec_user.email = ''
      expect(spec_user).not_to be_valid
    end

    it '#email is not uniqueness' do
      spec_another_user.email = spec_user.email
      expect(spec_another_user).not_to be_valid
    end
  end

  context 'when checks ownerships' do
    context 'returns true when' do
      it 'has stock' do
        expect(spec_user.has_stock?(
          spec_user.stocks.first.symbol,
          spec_user.portfolios.first.id
        )).to eq(true)
      end
      it 'has portfolio' do
        expect(spec_user.has_portfolio?(
          spec_user.portfolios.first.id
        )).to eq(true)
      end
    end

    context 'returns false when' do
      it 'hasnt stock' do
        expect(spec_user.has_stock?(
          (attributes_for(:stock)[:symbol] * 2),
          spec_user.portfolios.first.id + 1
        )).to eq(false)
      end
      it 'hasnt portfolio' do
        expect(spec_user.has_portfolio?(
          (spec_user.portfolios.first.id + 1)
        )).to eq(false)
      end
    end
  end

  describe 'associations' do
    it { should have_many(:portfolios).dependent(:destroy) }
    it { should have_many(:stocks).dependent(:destroy) }
  end
end

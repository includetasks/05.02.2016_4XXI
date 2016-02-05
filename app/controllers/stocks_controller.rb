# == Schema Information
#
# Table name: stocks
#
#  id           :integer          not null, primary key
#  symbol       :string           not null
#  count        :integer          default(1), not null
#  portfolio_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class StocksController < ApplicationController
  before_action -> {
    unless current_user.has_portfolio?(params[:portfolio_id])
      redirect_to portfolios_path
    end
  }

  # POST /portfolios/:portfolio_id/stocks
  def create
    stock_symbol = permitted_params[:symbol]

    if current_user.has_stock?(permitted_params[:symbol], params[:portfolio_id])
      stock = current_user.stocks.find_by(
        symbol:       stock_symbol,
        portfolio_id: params[:portfolio_id]
      )
      stock.increase
      stock.save
      flash[:notice] = 'Stock count increased!'
    else
      stock = current_user.stocks.create(
        portfolio_id: params[:portfolio_id],
        symbol:       stock_symbol
      )
      if stock.errors.empty?
        flash[:notice] = 'New stock created!'
      else
        flash[:alert] = stock.errors
      end
    end

    redirect_to portfolio_path(id: params[:portfolio_id])
  end

  # DELETE /portfolios/:portfolio_id/stocks/:id
  def destroy
    if Stock.exists?(user: current_user, id: params[:id])
      stock = current_user.stocks.find_by(id: params[:id])
      stock.decrease
      
      if stock.count <= 0
        stock.destroy
        flash[:notice] = 'Stock destroyed!'
      else
        stock.save
        flash[:notice] = 'Stock count decreased!'
      end
    else
      flash[:notice] = 'Stock is not exists!'
    end

    redirect_to portfolio_path(id: params[:portfolio_id])
  end

  private

  def permitted_params
    params.require(:stock).permit(:symbol)
  end
end

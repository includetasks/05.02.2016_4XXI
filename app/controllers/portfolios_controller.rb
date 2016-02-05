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

class PortfoliosController < ApplicationController
  
  # Generates 404 page if the current portfolio is not exists or user is not an owner.
  before_action :portfolio_exists?, only: [:show, :edit, :update, :destroy]

  # Redirects to portfolios path (if user is not an owner of the current portfolio)
  before_action :user_owns_portfolio?, only: [:show, :edit, :update, :destroy]

  # GET /portfolios
  def index
    @portfolios = current_user.portfolios
    @empty_portfolio = Portfolio.new
  end

  # GET /portfolios/:id
  def show
    @stock = Stock.new
    gon.portfolio = {
      title:  @portfolio.title,
      stocks: @portfolio.stocks
    }
  end

  # GET /portfolios/:id/edit
  def edit
  end

  # POST /portfolios
  def create
    @portfolio = current_user.portfolios.create(permitted_params)

    if @portfolio.errors.empty?
      flash[:notice] = 'New portfolio created!'
      redirect_to portfolios_path
    else
      flash[:alert] = @portfolio.errors
      redirect_to portfolios_path
    end
  end

  # PATCH /portfolios/:id
  # PUT   /portfolios/:id
  def update
    if @portfolio.update(permitted_params)
      flash[:notice] = 'Portfolio successfully updated!'
      redirect_to portfolios_path
    else
      flash[:alert] = @portfolio.errors
      render 'edit'
    end
  end

  # DELETE /portfolios/:id
  def destroy
    if @portfolio.destroy
      flash[:notice] = 'Portfolio successfully destroyed!'
      redirect_to portfolios_path
    else
      flash[:alert] = @portfolio.errors
      redirect_to portfolios_path # TODO: redirect to last page
    end
  end

  private

  # Will render 404 page if the current portfolio is not exists or user is not an owner.
  def portfolio_exists?
    @portfolio = current_user.portfolios.find_by(id: params[:id])
    render(
      file: "#{Rails.root}/public/404",
      layout: false,
      status: :not_found
    ) if @portfolio.nil?
  end

 # Redirects to portfolios path (if user is not an owner of the current portfolio)
  def user_owns_portfolio?
    unless current_user.has_portfolio?(params[:id])
      flash[:alert] = {
        portfolio_controller: 'You are not an owner of the chosen portfolio.'
      }
      redirect_to portfolios_path
    end
  end

  def permitted_params
    params.require(:portfolio).permit(:title)
  end
end

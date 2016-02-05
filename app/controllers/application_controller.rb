class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # All action can be invoked only by authenticated user.
  before_action :authenticate_user!

  # Custom devise model parameters callback.
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Map flash messages to the GON JS container
  before_action :map_flash_to_gon, unless: :devise_controller?
  # Map standard GON container (only for devise controller)
  before_action :generate_standard_gon, if: :devise_controller?

  protected

  # Standard gon contailer generator
  def generate_standard_gon
    gon.flash = { type: 'none', message: '' }
  end

  # Maps flash messages to the gon container
  def map_flash_to_gon
    generate_standard_gon
    if flash[:notice]
      gon.flash[:type]    = :notice
      gon.flash[:message] = flash[:notice]
    elsif flash[:alert]
      gon.flash[:type]    = :alert
      gon.flash[:message] = flash[:alert]
    end
  end

  # Parameters configuartion for devise models
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |user|
      user.permit(:name, :email, :user_avatar, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |user|
      user.permit(:name, :email, :user_avatar, :password, :password_confirmation, :current_password, :commit)
    end
  end
end

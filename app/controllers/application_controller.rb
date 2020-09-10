class ApplicationController < ActionController::Base
  before_action :authenticate_user!
   before_action :set_counter
  include Pundit

  after_action :verify_authorized, except: [ :index, :home ], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  # before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :name, :description])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :name, :description])
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^products$)/
  end

  def set_counter
    @product_order_count = ProductOrder.count
  end
end

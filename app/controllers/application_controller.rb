class ApplicationController < ActionController::Base

  #before_action :authenticate_customer!, except: [:new, :top, :about, :index, :create]

  #before_action :authenticate_admin!, except: [:new, :top, :about, :index, :create]

  before_action :authenticate_admin!, if: :admin_url

  before_action :configure_permitted_parameters, if: :devise_controller?

  def admin_url
    request.fullpath.include?("/admin")
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_homes_top_path
    when Customer
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :admin
      new_admin_session_path
    when :customer
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number])
  end
end
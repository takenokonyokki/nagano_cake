class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_homes_top_path
    when Customer

    end

  end
  
  
end

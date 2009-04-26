# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '08168a9889846ca9c99a58dbc1f9411e'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  private
    def authorize
      unless logged_in?
        session[:protected_page] = request.request_uri
        flash[:notice] = "Por favor, haga login primero"
         redirect_to(:controller => 'sessions', :action => 'new')
        return false
      end      
    end
    
    def login_and_return
      session[:return_url] = request.env["HTTP_REFERER"]
    end

end

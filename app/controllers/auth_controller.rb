class AuthController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:login]

  def login
    if request.post?
      user=User.authenticate(params[:name], params[:password])
      if user
        session[:user_id]=user.id
        uri=session[:original_uri]
        session[:original_uri]=nil
        redirect_to(uri||{:controller => "users", :action => user.id})
      else
        flash.now[:error]="Invalid username or password"
      end
    end
  end

  def logout
    session[:user_id]=nil
    flash[:notice]="Logouted"
    redirect_to(:action=>"login")
  end

  def index
  end

end

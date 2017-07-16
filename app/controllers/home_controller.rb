class HomeController < ApplicationController
  def index
    flash.keep
    if user_signed_in?
      redirect_to mailbox_inbox_path
    else
      flash[:warning] = "This is a demo application and your data will be deleted after 1 day." if 'true' == ENV['DEMO_MODE']
      redirect_to new_user_session_path
    end
  end

  def unmatched_route
    flash[:error] = 'Page not found'
    redirect_to root_path
  end
end

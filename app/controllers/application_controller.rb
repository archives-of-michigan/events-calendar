class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :choose_layout

private
  def choose_layout
    if params[:category_id] == 'Civil war'
      'civil_war'
    else
      'teach'
    end
  end
end

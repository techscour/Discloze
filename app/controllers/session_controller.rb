class SessionController < ApplicationController

  skip_before_action :require_login, only: [:landing, :signin, :signup,\
   :authorize, :preset, :ask, :abandon, :add, :about]
  include SessionHelper 

  def landing
    extend Rails.application.routes.url_helpers
  end

  def about
  end

  def signin
  end

  def signup
    render :signup, :locals => {:values => {}}
  end

  def update
    account = stormpath_get_account
    values = {
      'email' => account.email,
      'href' => account.href,
      'first' => account.given_name,
      'last' => account.surname,
      'zip' => '',
      'year' => '',
      'gender' => ''
      }
    render :update, :locals => {:values => values}
  end

  def passup

  end

  def preset
  end

  def amend
    amended = stormpath_update_account params
    if amended == true
      flash[:notice] = "Your account has been updated."
      redirect_to root_url
    else
      flash[:alert] = amended
      render :update,   :locals => {:values => params}
    end
  end

  def alter
    altered = stormpath_change_password params['old'], params['new1']
    if altered == true
      flash[:notice] = "You password has been changed."
      redirect_to  root_url 
    else
      flash[:alert] = altered
      render :passup,   :locals => {:values => params}
    end
  end

  def add
    added = stormpath_create_account params
    if added == true
      flash[:notice] = "Your account confirmation email is on the way."
      redirect_to root_url
    else
      flash[:alert] = added
      render :signup,   :locals => {:values => params}
    end
  end

  def authorize
    authorized = stormpath_authenticate_login params['email'], params['password']
    if authorized == true
      publik = Public.find_or_create_by(stormpath_id: session[:user])
      publik.last_login = Time.now.utc
      session[:user_id] = publik.id
      flash.clear
      redirect_to  root_url
    else
      puts authorized.to_s
      flash[:alert] = authorized.to_s
      render :signin
    end
  end

  def abandon
    reset_session
    redirect_to root_url
  end

  def ask
    asked = stormpath_request_password_reset params
    if asked == true
      flash[:notice] = "Your password reset email is on the way."
      redirect_to root_url
    else
      flash[:notice] = asked
      render :preset
    end
  end

  def abolish
    stormpath_delete_account
    pub = Public.find_by_stormpath_id('David')
    pub.destroy
    reset_session
    redirect_to root_url
    flash[:notice] = "Your account has been deleted."
  end
end

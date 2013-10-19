require 'csv'
class SessionController < ApplicationController

  skip_before_action :require_login, only: [:landing, :signin, :signup,\
   :authorize, :preset, :ask, :abandon, :add, :about, :create, :destroy, :failure]
  include SessionHelper 

  def download
    list = List.where(:name => params['name'], :public_id => session[:user_id]).first
    rows = JSON.parse(list.values).collect{|x| [ list.name, x['item'], "#{x['rating']}" ]}
    rows.unshift %w[list item rating] 
    rows = rows.collect{|row| row.to_csv}.join 
    response.headers['Content-Disposition'] = "attachment; filename=\"#{list.name}.csv\""
    render  :text => rows, :content_type =>  Mime::CSV, :staus => :ok
  end

  def mail
    list = List.where(:name => params['list'], :public_id => session[:user_id]).first
    mail = Mail.new
    message = params['body'] + "\n\n" + format_list(list)
    mail.to params['mail_to']
    mail.from session[:user_email] 
    mail.subject params['subject']
    mail.text_part do
        body message
    end
    mail.deliver
    render :json => 'true' 
  end

  def landing
    extend Rails.application.routes.url_helpers
  end

  def create
    auth_hash = request.env['omniauth.auth']
    render :json => auth_hash
  end
  
  def destroy
    session[:user_id] = nil
    render :text => "You've logged out"
  end
  
  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end

  def about
  end

  def signin
  end

  def signup
    @values = {}
    render :signup
  end

  def update
    account = stormpath_get_account
    @values = {
      'email' => account.email,
      'href' => account.href,
      'first' => account.given_name,
      'last' => account.surname,
      'zip' => '',
      'year' => '',
      'gender' => ''
      }
    render :update
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
      @values = params
      render :update 
    end
  end

  def alter
    altered = stormpath_change_password params['old'], params['new1']
    if altered == true
      flash[:notice] = "You password has been changed."
      redirect_to  root_url 
    else
      flash[:alert] = altered
      render :passup
    end
  end

  def add
    added = stormpath_create_account params
    if added == true
      flash[:notice] = "Your account confirmation email is on the way."
      redirect_to root_url
    else
      flash[:alert] = added
      @values = params
      render :signup
    end
  end

  def authorize
    authorized = stormpath_authenticate_login params['email'], params['password']
    if authorized == true
      publik = Public.find_or_create_by(stormpath_id: session[:user])
      publik.last_login = Time.now.utc
      session[:user_id] = publik.id
      session[:user_email] = params['email']
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
    Public.find_by_stormpath_id(session[:user]).destroy!
    reset_session
    redirect_to root_url
    flash[:notice] = "Your account has been deleted."
  end
end

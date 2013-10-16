class LoginsController < ApplicationController
  before_action :set_login, only: [:edit, :update, :destroy]

  # POST /logins
  def create
    @login = Login.new(login_params)

    if @login.save
      render :json => "ok"
    else
      render :json => "failed"
    end
  end

  # PATCH/PUT /logins/1
  def update
      if @login.update(login_params)
        render :json => "ok"
      else
        render :json => "failed"
      end
  end

  # DELETE /logins/1
  def destroy
    @login.destroy
    render :json => "ok"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_login
      @login = Login.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def login_params
      params.require(:login).permit(:public_id, :last_activity, :remember)
    end
end

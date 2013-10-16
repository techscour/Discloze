class TokensController < ApplicationController
  before_action :set_token, only: [:show, :edit, :update, :destroy]

  def create
    @token = Token.new(token_params)
      if @token.save
        render :json => "ok"
      else
        render :json => "failed"
      end
    end
  end

  # DELETE /tokens/1
  def destroy
    @token.destroy
    render :json => "ok"
  end

  private
    def set_token
      @token = Token.find(params[:id])
    end

    def token_params
      params.require(:token).permit(:partner_id, :token_value, :last_login, :last_activity)
    end
end

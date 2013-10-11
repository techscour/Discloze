class EditsController < ApplicationController


  # GET /logins
  # GET /logins.json
  #def index
  #end

  # GET /logins/1
  # GET /logins/1.json
  #def show
  #end

  # GET /logins/new
  #def new
  #end

  # GET /logins/1/edit
  def edit
  #   puts params.inspect;
  #   data = [
  #     {
  #       'item' => 'item 1',
  #       'rating' => 8
  #     },
  #     {
  #       'item' => 'item 2',
  #       'rating' => 7
  #     }
  #   ]
    list = List.find(params['id'])
    render  :locals => {:data => list.values, :name =>  list.name, :visibility => list.visibility,\
      :user_id => params['public_id'], :id => params['id'] }
  end

  # POST /logins
  # POST /logins.json
  #def create
  #end

  # PATCH/PUT /logins/1
  # PATCH/PUT /logins/1.json
  #def update
  #end

  # DELETE /logins/1
  # DELETE /logins/1.json
  #def destroy
  #end

  private


    # Never trust parameters from the scary internet, only allow the white list through.
    def login_params
      params.require(:login).permit(:public_id, :last_activity, :remember)
    end
end

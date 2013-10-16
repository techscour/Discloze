class PublicsController < ApplicationController
  before_action :set_public, only: [:show, :edit, :update, :destroy]

  # GET /publics
  # GET /publics.json
  #def index
    #@publics = Public.all
  #end

  # GET /publics/1
  # GET /publics/1.json
  #def show
  #end

  # GET /publics/new
  #def new
    #@public = Public.new
  #end

  # GET /publics/1/edit
  #def edit
  #end

  # POST /publics
  # POST /publics.json
  def create
    @public = Public.new(public_params)
    #respond_to do |format|
      if @public.save
        #format.html { redirect_to @public, notice: 'Public was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @public }
        render :json => "ok"
      else
        render :json => "failed"    
        #format.html { render action: 'new' }
        #format.json { render json: @public.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publics/1
  # PATCH/PUT /publics/1.json
  #def update
    #respond_to do |format|
      #if @public.update(public_params)
        #format.html { redirect_to @public, notice: 'Public was successfully updated.' }
        #format.json { head :no_content }
      #else
        #format.html { render action: 'edit' }
        #format.json { render json: @public.errors, status: :unprocessable_entity }
      #end
    #end
  #end

  # DELETE /publics/1
  # DELETE /publics/1.json
  def destroy
    @public.destroy
    render :json => "ok"
    #respond_to do |format|
      #format.html { redirect_to publics_url }
      #format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_public
      @public = Public.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def public_params
      params.require(:public).permit(:stormpath_id, :last_login)
    end
end

class UpdatesController < ApplicationController
  before_action :set_update, only: [:show, :edit, :update, :destroy]

  # GET /updates
  # GET /updates.json
def index

  fetcher = lambda { |sort_field, direction, page, per|
    records = Update.joins(:partner).where(:public_id => @user_id)
    [records.count, records.order(sort_field + ' ' + direction).page(page).per(per)]
  }

  cooker = lambda  { |raws|
    raws.map do |raw|
      {
        'id' => raw.id,
        'headline' => raw.headline,
        'list' => raw.list,
        'partner'  => raw.partner.name,
        'posted'  => raw.posted,
        'html'  => raw.html
      }
    end
  } 

   callbacks = {
        :delete => {:controller => 'updates' }
      }

   columns = [  
      {field:'headline', displayName: 'Headline', order: 'headline'},
      {field:'list', displayName: 'List', order: 'list'},
      {field:'partner', displayName: 'Partner', order: 'partners.name'},
      {field:'posted', displayName:'Posted', order: 'posted'}
   ]

   angular_grid_simple_helper 'shared/angular_grid_partial', 'Your Updates', \
     fetcher, cooker, columns, callbacks
  end

  # GET /updates/1
  # GET /updates/1.json
  #def show
  #end

  # GET /updates/new
  #def new
    #@update = Update.new
  #end

  # GET /updates/1/edit
  #def edit
  #end

  # POST /updates
  # POST /updates.json
  def create
    @update = Update.new(update_params)
    respond_to do |format|
      if @update.save
        #format.html { redirect_to @update, notice: 'Update was successfully created.' }
        render :json => "ok"
        #format.json { render action: 'show', status: :created, location: @update }
      else
        render :json => "failed"
        #format.html { render action: 'new' }
        #format.json { render json: @update.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /updates/1
  # PATCH/PUT /updates/1.json
  #def update
    #respond_to do |format|
      #if @update.update(update_params)
        #format.html { redirect_to @update, notice: 'Update was successfully updated.' }
        #format.json { head :no_content }
      #else
        #format.html { render action: 'edit' }
        #format.json { render json: @update.errors, status: :unprocessable_entity }
      #end
    #end
  #end

  # DELETE /updates/1
  # DELETE /updates/1.json
  def destroy
    @update.destroy
    render :json => "ok"
    #respond_to do |format|
      #format.html { redirect_to updates_url }
      #format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_update
      @update = Update.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def update_params
      params.require(:update).permit(:public_id, :partner_id, :list, :headline, :html, :posted, :effective, :expires)
    end
end

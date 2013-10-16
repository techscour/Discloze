class PartnerAppsController < ApplicationController
  before_action :set_partner_app, only: [:show, :edit, :update, :destroy]

  # GET /partner_apps
  # GET /partner_apps.json
def index

   fetcher = lambda { |sort_field, direction, page, per|
    records = PartnerApp.joins(:partner)
    [records.count, records.order(sort_field + ' ' + direction).page(page).per(per)]
  }

  cooker = lambda  { |raws|
    raws.map do |raw|
      {
        'id' => raw.id,
        'app_name' => raw.name,
        'html' => raw.html,
        'url' => raw.url,
        'partner_name' => raw.partner.name,
        'description'  => raw.description
      }
    end
  } 

  callbacks = {
    :create => {:controller => 'partner_apps' }
    }

  columns = [  
     {field:'app_name', displayName: 'App Name', order: 'name'},
     {field:'partner_name', displayName: 'Partner', order: 'name'},
     {field:'description', displayName:'Description', order: 'description'},
     {field:'url', displayName: 'Url', order: 'url'}
  ]

   angular_grid_simple_helper 'shared/angular_grid_partial', 'Partner Apps', \
     fetcher, cooker, columns, callbacks
  end


  # GET /partner_apps/1
  # GET /partner_apps/1.json
  #def show
  #end

  # GET /partner_apps/new
  #def new
    #@partner_app = PartnerApp.new
  #end

  # GET /partner_apps/1/edit
  #def edit
  #end

  # POST /partner_apps
  # POST /partner_apps.json
  def create
    if AppOfPublic.where(partner_app_id:  params['_json'], public_id: session['user_id']).exists?
      render :text => 'Duplicate App'
    else
      AppOfPublic.create partner_app_id:  params['_json'], public_id: session['user_id']
      render :text => "App Created"
    end
  end

  # PATCH/PUT /partner_apps/1
  # PATCH/PUT /partner_apps/1.json
  #def update
    #respond_to do |format|
      #if @partner_app.update(partner_app_params)
        #format.html { redirect_to @partner_app, notice: 'Partner app was successfully updated.' }
        #format.json { head :no_content }
      #else
        #format.html { render action: 'edit' }
        #format.json { render json: @partner_app.errors, status: :unprocessable_entity }
      #end
    #end
  #end

  # DELETE /partner_apps/1
  # DELETE /partner_apps/1.json
  #def destroy
    #@partner_app.destroy
    #render :json => "ok"
    #respond_to do |format|
      #format.html { redirect_to partner_apps_url }
      #format.json { head :no_content }
    #end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_partner_app
      @partner_app = PartnerApp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def partner_app_params
      params.require(:partner_app).permit(:partner_id, :name, :description, :url)
    end
end

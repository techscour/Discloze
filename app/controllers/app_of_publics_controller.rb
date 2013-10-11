class AppOfPublicsController < ApplicationController
  before_action :set_app_of_public, only: [:show, :edit, :update, :destroy]

  # GET /app_of_publics
  # GET /app_of_publics.json
def index

   fetcher = lambda { |sort_field, direction, page, per|
    records = AppOfPublic.joins({partner_app: :partner}, :public).where(:public_id => @user_id)
    [records.count, records.order(sort_field + ' ' + direction).page(page).per(per)]
  }

  cooker = lambda  { |raws|
    raws.map do |raw|
      {
        'id' => raw.id,
        'app_name' => raw.partner_app.name,
        'partner_name' => raw.partner_app.partner.name,
        'description'  => raw.partner_app.description,
        'html'  => raw.partner_app.html
      }
    end
  } 

   callbacks = {
        :delete => {:controller => 'app_of_publics' }
      }

   columns = [  
      {field:'app_name', displayName: 'Application', order: 'partner_apps.name'},
      {field:'partner_name', displayName: 'Partner', order: 'partners.name'},
      {field:'description', displayName:'Description', order: 'partner_apps.description'}
   ]


   angular_grid_simple_helper 'shared/angular_grid_partial', 'Your Apps', \
     fetcher, cooker, columns, callbacks
  end

  # GET /app_of_publics/1
  # GET /app_of_publics/1.json
  def show
  end

  # GET /app_of_publics/new
  def new
    @app_of_public = AppOfPublic.new
  end

  # GET /app_of_publics/1/edit
  def edit
  end

  # POST /app_of_publics
  # POST /app_of_publics.json
  def create
    @app_of_public = AppOfPublic.new(app_of_public_params)

    respond_to do |format|
      if @app_of_public.save
        format.html { redirect_to @app_of_public, notice: 'App of public was successfully created.' }
        format.json { render action: 'show', status: :created, location: @app_of_public }
      else
        format.html { render action: 'new' }
        format.json { render json: @app_of_public.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_of_publics/1
  # PATCH/PUT /app_of_publics/1.json
  def update
    respond_to do |format|
      if @app_of_public.update(app_of_public_params)
        format.html { redirect_to @app_of_public, notice: 'App of public was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @app_of_public.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_of_publics/1
  # DELETE /app_of_publics/1.json
  def destroy
    @app_of_public.destroy
    respond_to do |format|
      format.html { redirect_to app_of_publics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_of_public
      @app_of_public = AppOfPublic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_of_public_params
      params.require(:app_of_public).permit(:public_id, :partner_app_id)
    end
end

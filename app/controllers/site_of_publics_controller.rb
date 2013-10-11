class SiteOfPublicsController < ApplicationController
  before_action :set_site_of_public, only: [:show, :edit, :update, :destroy]

  # GET /site_of_publics
  # GET /site_of_publics.json
 def index

   fetcher = lambda { |sort_field, direction, page, per|
    records = SiteOfPublic.joins({partner_site: :partner}, :public).where(:public_id => @user_id)
    [records.count, records.order(sort_field + ' ' + direction).page(page).per(per)]
  }

  cooker = lambda  { |raws|
    raws.map do |raw|
      {
        'id' => raw.id,
        'site_name' => raw.partner_site.name,
        'partner_name' => raw.partner_site.partner.name,
        'description'  => raw.partner_site.description,
        'html'  => raw.partner_site.html
      }
    end
  } 

   callbacks = {
        :delete => {:controller => 'site_of_publics'  }
      }

   columns = [  
      {field:'site_name', displayName: 'Application', order: 'partner_sites.name'},
      {field:'partner_name', displayName: 'Partner', order: 'partners.name'},
      {field:'description', displayName:'Description', order: 'partner_sites.description'}
   ]


   angular_grid_simple_helper 'shared/angular_grid_partial', 'Your Sites', \
     fetcher, cooker, columns, callbacks
  end

  # GET /site_of_publics/1
  # GET /site_of_publics/1.json
  def show
  end

  # GET /site_of_publics/new
  def new
    @site_of_public = SiteOfPublic.new
  end

  # GET /site_of_publics/1/edit
  def edit
  end

  # POST /site_of_publics
  # POST /site_of_publics.json
  def create
    @site_of_public = SiteOfPublic.new(site_of_public_params)

    respond_to do |format|
      if @site_of_public.save
        format.html { redirect_to @site_of_public, notice: 'Site of public was successfully created.' }
        format.json { render action: 'show', status: :created, location: @site_of_public }
      else
        format.html { render action: 'new' }
        format.json { render json: @site_of_public.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /site_of_publics/1
  # PATCH/PUT /site_of_publics/1.json
  def update
    respond_to do |format|
      if @site_of_public.update(site_of_public_params)
        format.html { redirect_to @site_of_public, notice: 'Site of public was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @site_of_public.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_of_publics/1
  # DELETE /site_of_publics/1.json
  def destroy
    @site_of_public.destroy
    respond_to do |format|
      format.html { redirect_to site_of_publics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site_of_public
      @site_of_public = SiteOfPublic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_of_public_params
      params.require(:site_of_public).permit(:public_id, :partner_site_id)
    end
end

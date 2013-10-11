class PartnerSitesController < ApplicationController
  #before_action :set_partner_site, only: [:show, :edit, :update, :destroy]

  # GET /partner_sites
  # GET /partner_sites.json
def index

   fetcher = lambda { |sort_field, direction, page, per|
    records = PartnerSite.joins(:partner)
    [records.count, records.order(sort_field + ' ' + direction).page(page).per(per)]
  }

  cooker = lambda  { |raws|
    raws.map do |raw|
      {
        'id' => raw.id,
        'site_name' => raw.name,
        'html' => raw.html,
        'url' => raw.url,
        'partner_name' => raw.partner.name,
        'description'  => raw.description
      }
    end
  } 
  callbacks = {
    :create => {:controller => 'partner_sites' }
    }
  columns = [  
    {field:'site_name', displayName: 'Site Name', order: 'name'},
    {field:'partner_name', displayName: 'Partner', order: 'name'},
    {field:'description', displayName:'Description', order: 'description'},
    {field:'url', displayName: 'Url', order: 'url'}
  ]


   angular_grid_simple_helper 'shared/angular_grid_partial', 'Partner Sites', \
     fetcher, cooker, columns, callbacks
  end

  # GET /partner_sites/1
  # GET /partner_sites/1.json
  def show
  end

  # GET /partner_sites/new
  def new
    @partner_site = PartnerSite.new
  end

  # GET /partner_sites/1/edit
  def edit
  end

  # POST /partner_sites
  # POST /partner_sites.json
  def create
    site_id = params['_json']
    public_id = params['public_id']
    site = PartnerSite.find(site_id)
    duplicates = SiteOfPublic.where("public_id = #{public_id} and partner_site_id = #{site_id}")
    if duplicates.count.zero?
      SiteOfPublic.create(public_id: public_id, partner_site_id: site_id) 
      render :text => "#{site.name} Created"
    else
      render :text => 'Duplicate Site'
    end
  end

  # PATCH/PUT /partner_sites/1
  # PATCH/PUT /partner_sites/1.json
  def update
    respond_to do |format|
      if @partner_site.update(partner_site_params)
        format.html { redirect_to @partner_site, notice: 'Partner site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @partner_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /partner_sites/1
  # DELETE /partner_sites/1.json
  def destroy
    @partner_site.destroy
    respond_to do |format|
      format.html { redirect_to partner_sites_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_partner_site
      #@partner_site = PartnerSite.find(params[:id])
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def partner_site_params
      #params.permit(:partner_id, :site_of_public, :name, :description, :url)
    #end
end

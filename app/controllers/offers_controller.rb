class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  # GET /offers
  # GET /offers.json
def index

  fetcher = lambda { |sort_field, direction, page, per|
    records = Offer.joins(:partner).where(:public_id => @user_id)
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
        :delete => {:controller => 'offers', :action => 'delete' }
      }

   columns = [  
      {field:'headline', displayName: 'Headline', order: 'headline'},
      {field:'list', displayName: 'List', order: 'list'},
      {field:'partner', displayName: 'Partner', order: 'partners.name'},
      {field:'posted', displayName:'Posted', order: 'posted'}
   ]

   angular_grid_simple_helper 'shared/angular_grid_partial', 'Your Offers', \
     fetcher, cooker, columns, callbacks
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
  end

  # GET /offers/new
  def new
    @offer = Offer.new
  end

  # GET /offers/1/edit
  def edit
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer, notice: 'Offer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @offer }
      else
        format.html { render action: 'new' }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(:public_id, :partner_id, :list, :headline, :html, :posted, :effective, :expires)
    end
end

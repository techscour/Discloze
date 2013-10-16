class OffersController < ApplicationController
  before_action :set_offer, only: [:destroy]

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

  # POST /offers
  def create
    @offer = Offer.new(offer_params)
      if @offer.save
        render :json => "ok"
      else
        render :json => "failed"
      end
  end

  # DELETE /offers/1
  def destroy
    @offer.destroy
    render :json => "ok"
  end

  private
    def set_offer
      @offer = Offer.where(:id=>params[:id],:public_id => @user_id).first
    end

    def offer_params
      params.require(:offer).permit(:public_id, :partner_id, :list, :headline, :html, :posted, :effective, :expires)
    end
end

class UpdatesController < ApplicationController
  before_action :set_update, only: [:destroy]

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

  # POST /updates
  def create
    @update = Update.new(update_params)
      if @update.save
        render :json => "ok"
      else
        render :json => "failed"
      end
  end

  # DELETE /updates/1
  def destroy
    @update.destroy
    render :json => "ok"
  end

  private
    def set_update
      @update = Update.where(:id=>params[:id],:public_id => @user_id).first
    end

    def update_params
      params.require(:update).permit(:public_id, :partner_id, :list, :headline, :html, :posted, :effective, :expires)
    end
end

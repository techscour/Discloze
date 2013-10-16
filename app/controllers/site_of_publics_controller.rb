class SiteOfPublicsController < ApplicationController
  before_action :set_site_of_public, only: [:show, :edit, :update, :destroy]

  # GET /site_of_publics
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

  # DELETE /site_of_publics/1
  def destroy
    @site_of_public.destroy
    render :json => "ok"
  end

  private
    def set_site_of_public
      @site_of_public = SiteOfPublic.where(:id=>params[:id],:public_id => @user_id).first
    end

    def site_of_public_params
      params.require(:site_of_public).permit(:public_id, :partner_site_id)
    end
end

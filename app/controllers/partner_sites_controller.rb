class PartnerSitesController < ApplicationController

  # GET /partner_sites
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

  # POST /partner_sites
  def create
    if SiteOfPublic.where(partner_site_id:  params['_json'], public_id: session['user_id']).exists?
      render :text => 'Duplicate App'
    else
      SiteOfPublic.create partner_site_id:  params['_json'], public_id: session['user_id']
      render :text => "App Created"
    end
  end

end

class PartnerAppsController < ApplicationController

  # GET /partner_apps
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

  # POST /partner_apps
  def create
    if AppOfPublic.where(partner_app_id:  params['_json'], public_id: session['user_id']).exists?
      render :text => 'Duplicate App'
    else
      AppOfPublic.create partner_app_id:  params['_json'], public_id: session['user_id']
      render :text => "App Created"
    end
  end

end

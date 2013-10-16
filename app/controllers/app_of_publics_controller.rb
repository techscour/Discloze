class AppOfPublicsController < ApplicationController
  before_action :set_app_of_public, only: [:destroy]

  # GET /app_of_publics
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

  # DELETE /app_of_publics/1
  # DELETE /app_of_publics/1.json
  def destroy
    @app_of_public.destroy
    render :json => "ok"
  end

  private
    def set_app_of_public
      @app_of_public = AppOfPublic.where(:id=>params[:id],:public_id => @user_id).first
    end

    def app_of_public_params
      params.require(:app_of_public).permit(:public_id, :partner_app_id)
    end
end

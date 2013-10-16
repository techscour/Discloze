class NoticesController < ApplicationController
  before_action :set_notice, only: [:destroy]

  # GET /notices
 def index

   fetcher = lambda { |sort_field, direction, page, per|
    records = Notice.where(:public_id => @user_id)
    [records.count, records.order(sort_field + ' ' + direction).page(page).per(per)]
  }

  cooker = lambda  { |raws|
    raws.map do |raw|
      {
        'id' => raw.id,
        'headline' => raw.headline,
        'posted' => raw.posted,
        'html' => raw.html
      }
    end
  } 

   callbacks = {
        :delete => {:controller => 'notices', :action => 'delete' }
      }

   columns = [  
      {field:'headline', displayName: 'Headline', order: 'headline'},
      {field:'posted', displayName: 'Posted', order: 'posted'},
   ]

   angular_grid_simple_helper 'shared/angular_grid_partial', 'Your Notices', \
     fetcher, cooker, columns, callbacks
  end

  # POST /notices
  def create
    @notice = Notice.new(notice_params)
    respond_to do |format|
      if @notice.save
        render :json => "ok"
      else
        render :json => "ok"
      end
    end
  end

  # DELETE /notices/1
  def destroy
    @notice.destroy
    render :json => "ok"
  end

  private
    def set_notice
      @notice = Notice.find(params[:id])
    end

    def notice_params
      params.require(:notice).permit(:public_id, :headline, :content, :posted)
    end
end

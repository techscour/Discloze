class NoticesController < ApplicationController
  before_action :set_notice, only: [:show, :edit, :update, :destroy]

  # GET /notices
  # GET /notices.json
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

  # GET /notices/new
  #def new
    #@notice = Notice.new
  #end

  # GET /notices/1/edit
  #def edit
  #end

  # POST /notices
  # POST /notices.json
  def create
    @notice = Notice.new(notice_params)

    respond_to do |format|
      if @notice.save
        render :json => "ok"
        #format.html { redirect_to @notice, notice: 'Notice was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @notice }
      else
        render :json => "ok"
        #format.html { render action: 'new' }
        #format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notices/1
  # PATCH/PUT /notices/1.json
  #def update
    #respond_to do |format|
      #if @notice.update(notice_params)
        #format.html { redirect_to @notice, notice: 'Notice was successfully updated.' }
        #format.json { head :no_content }
      #else
        #format.html { render action: 'edit' }
        #format.json { render json: @notice.errors, status: :unprocessable_entity }
      #end
    #end
  #end

  # DELETE /notices/1
  # DELETE /notices/1.json
  def destroy
    @notice.destroy
    render :json => "ok"
    #respond_to do |format|
      #format.html { redirect_to notices_url }
      #format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notice
      @notice = Notice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notice_params
      params.require(:notice).permit(:public_id, :headline, :content, :posted)
    end
end

class ListablesController < ApplicationController
  before_action :set_listable, only: [:show, :edit, :update, :destroy]

  # GET /listables
  # GET /listables.json
def index

   fetcher = lambda { |sort_field, direction, page, per|
    records = Listable.all
    [records.count, records.order(sort_field + ' ' + direction).page(page).per(per)]
  }

  cooker = lambda  { |raws|
    raws.map do |raw|
      {
        'id' => raw.id,
        'name' => raw.name,
        'html' => raw.html,
        'topic' => raw.topic,
        'description'  => raw.description
      }
    end
  } 
  callbacks = {
    :create => {:controller => 'lists' }
  }
  columns = [  
    {field:'name', displayName: 'List Name', order: 'name'},
    {field:'topic', displayName: 'Topic', order: 'topic'},
    {field:'description', displayName:'Description', order: 'description'}
  ]


   angular_grid_simple_helper 'shared/angular_grid_partial', 'List Varieties', \
     fetcher, cooker, columns, callbacks
  end





  # GET /listables/1
  # GET /listables/1.json
  #def show
  #end

  # GET /listables/new
  #def new
    #@listable = Listable.new.to_json
  #end

  # GET /listables/1/edit
  #def edit
  #end

  # POST /listables
  # POST /listables.json
  def create
    @listable = Listable.new(listable_params)

    respond_to do |format|
      if @listable.save
        #format.html { redirect_to @listable, notice: 'Listable was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @listable }
        render :json => "ok"
      else
        render :json => "failed"
        #format.html { render action: 'new' }
        #format.json { render json: @listable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listables/1
  # PATCH/PUT /listables/1.json
  #def update
    #respond_to do |format|
      #if @listable.update(listable_params)
        #format.html { redirect_to @listable, notice: 'Listable was successfully updated.' }
        #format.json { head :no_content }
      #else
        #format.html { render action: 'edit' }
        #format.json { render json: @listable.errors, status: :unprocessable_entity }
      #end
    #end
  #end

  # DELETE /listables/1
  # DELETE /listables/1.json
  def destroy
    @listable.destroy
    render :json => "ok"
    #respond_to do |format|
      #format.html { redirect_to listables_url }
      #format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listable
      @listable = Listable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listable_params
      params.require(:listable).permit(:name, :topic, :description)
    end
end

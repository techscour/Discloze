class ListablesController < ApplicationController
  before_action :set_listable, only: [:destroy]

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

  # POST /listables
  def create
    @listable = Listable.new(listable_params)
    if @listable.save
      render :json => "ok"
    else
      render :json => "failed"
    end
  end

  # DELETE /listables/1
  def destroy
    @listable.destroy
    render :json => "ok"
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

class ListsController < ApplicationController
  before_action :set_list, only: [:update, :destroy]

  # GET /lists
  def index
    fetcher = lambda { |sort_field, direction, page, per|
      records = List.where(:public_id => @user_id)
      [records.count, records.order(sort_field + ' ' + direction).page(page).per(per)]
    }

    cooker = lambda  { |raws|
      raws.map do |raw|
        {
          'id' => raw.id,
          'name' => raw.name,
          'visibility' => raw.visibility
        }
      end
    } 
    callbacks = {
      :edit => {:controller => 'lists' }
    }
    columns = [  
      {field:'name', displayName: 'Name', order: 'name'},
      {field:'visibility', displayName: 'Visbility', order: 'visibility'}
    ]

     angular_grid_simple_helper 'shared/angular_grid_partial', 'My Lists', \
       fetcher, cooker, columns, callbacks
    end

  # POST /lists
  def create
    listable = Listable.find_by_id(params['_json'])
    if listable.nil?
      render :json => 'Listable Not Found'
    elsif List.find_by_name(listable.name).present?
      render :json => 'Duplicate List'
    else
      list = List.create!(public_id:  @user_id, name: listable.name,\
       visibility: 'Public', values: '[{}]', created: Time.now.utc, \
       last_activity: Time.now.utc  )
      render :json => "#{listable.name} Created"
    end
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(:values => params[:values].to_json, :name => params[:name],\
       :visibility => params[:visibility]) 
      render :text => 'OK'
    else
      render :text => 'Oops', :status => :not_found
    end
  end

  # DELETE /lists/1
  def destroy
    @list.destroy
    render :nothing => true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.where(:id=>params[:id],:public_id => @user_id).first
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.permit(:id, :public_id, :name, :list, :visibility, values: [])
    end
end

class EditsController < ApplicationController
  def edit
    list = List.find(params['id'])
    @values = { :data => list.values, :name =>  list.name, :visibility => list.visibility,\
      :user_id => params['public_id'], :id => params['id'] }
    render  
  end
end

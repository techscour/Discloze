module ApplicationHelper
 
  def angular_grid_simple_helper partial, headline, fetcher, cooker, columns, callbacks={}
 
    page = params['page'].to_i
    size = params['size'].to_i 
    field = params['field']  || 'id'
    direction = params['direction']  || 'asc'

    page = 1 if !page.integer? || page.zero?
    size = 10 if !size.integer? || size.zero?
    field = 'id' if field == 'undefined' || !field
    direction = 'asc' if direction == 'undefined' || !direction

    sort_field = 'id'
    sort_field = columns.find {|x| x[:field] == field}[:order] unless field == 'id'

  
    total, items = fetcher[sort_field, direction, page, size]
    cooked = cooker[items]
    @values = {:data => cooked, :total =>  total, :columns => columns, \
     :size => size, :page => page, :field => field, :direction => direction, :header => headline, \
     :callbacks => callbacks, :user_id => @user_id }.to_json
    render partial
   end
end

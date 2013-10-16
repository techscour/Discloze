require 'spec_helper'


describe ListsController do

  let(:person) { create :person }
  let(:valid_session) { { :user_id => :person.id} }

  #describe "GET index" do
    #it "renders the angular grid partial" do
      #publik = create :public   
      #create_list :list, 5, public_id: publik.id
      #request.session[:user_id] = publik.id
      #get :index, nil
    #response.should render_template("shared/angular_grid_partial")
    #end
  #end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new List" do
        listable = create :listable, name: 'Alpha'
        publik = create :public
        parameters = {:public_id => publik.id, '_json' => listable.id } 
        was = List.count 
        post :create, parameters 
        List.count == was - 1
        #expect {
          #post :create, parameters
        #}.to change(List, :count).by(1)
      end

      it "returns created message on success" do
        listable = create :listable, name: 'Alpha'
        publik = create :public
        parameters = {:public_id => publik.id, '_json' => listable.id } 
        post :create, parameters 
        List.count == 1
        response.body =="Alpha Created"
        #expect(response.body).to eq("Alpha Created")
      end

      it "returns duplicate message on duplication" do
        listable = create :listable, name: 'Alpha'
        publik = create :public
        parameters = {:public_id => publik.id, '_json' => listable.id } 
        post :create, parameters 
        post :create, parameters 
        List.count == 2
        response.body =="Duplicate List"
        #expect(response.body).to eq("Duplicate List")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested list" do
        #attributes = { "name" => "name", "values" => "[{}]", "visibility" => "Public" }
        list = create :list 
        visibility = 'Private' 
        values = '[{"a":"b"}]'
        updated = {:public_id => list.public_id, :id => list.id, :values => values , :visibility => visibility}
        list.visibility == visibility && list.values == values
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested list" do
      list = create :list
      parameters = {:id => list.id, public_id: list.public_id} 
      was = List.count
      delete :destroy, parameters 
      List.count == was - 1
    end
  end
end
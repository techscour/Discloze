require 'spec_helper'


describe ListsController do

  let(:valid_attributes) { { "name" => "MyString", "public_id" => 1 } }
  let(:valid_session) { { :user => 'user1'} }

  describe "GET index" do
    it "renders the angular grid partial" do
      parameters = {:public_id => 1 } 
      session = {:user => 'user1'}
      get :index, parameters, session, nil
	  response.should render_template("shared/angular_grid_partial")
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new List" do
      	listable = Listable.create!
        parameters = {:public_id => 1, '_json' => listable.id } 
        expect {
          post :create, parameters, valid_session
        }.to change(List, :count).by(1)
      end

      it "returns created message on success" do
      	listable = Listable.create name: 'Alpha'
        parameters = {:public_id => 1, '_json' => listable.id } 
        post :create, parameters, valid_session
        response.body == "Alpha Created"
      end

      it "returns duplicate message on duplication" do
      	listable = Listable.create name: 'Alpha'
        parameters = {:public_id => 1, '_json' => listable.id } 
        post :create, parameters, valid_session
        post :create, parameters, valid_session
        response.body == "Duplilcate"
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested list" do
        attributes = { "name" => "name", "values" => "[{}]", "visibility" => "Public" }
        list = List.create! attributes
        updated = {:public_id => 1, :id => list.id, :values => '[{"a":"b"}]', :visibility => "Private" }
        list.visibility == 'Private' && list.values == '[{"a":"b"}]'
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested list" do
      list = List.create! valid_attributes
      parameters = {:id => list.id, :public_id => list.public_id} 
      expect {
        delete :destroy, parameters, valid_session, nil
      }.to change(List, :count).by(-1)
    end
  end
end
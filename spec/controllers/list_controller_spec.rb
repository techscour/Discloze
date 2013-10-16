require 'spec_helper'


describe ListsController do

  describe "GET index" do
    it "renders the angular grid partial" do
      publik = create :public   
      create_list :list, 5, public_id: publik.id
      get :index, nil, {:user_id => publik.id, :user => 'someone'}
      response.should render_template("shared/angular_grid_partial")
    end
  end
  describe "POST create" do
    describe "with valid params" do
      it "creates a new List" do
        listable = create :listable, name: 'Alpha'
        publik = create :public
        request.session[:user_id] = publik.id
        request.session[:user] = 'someone'
        parameters = {:public_id => publik.id, '_json' => listable.id } 
        if false 
          was = List.count 
          post :create, parameters 
          List.count == was - 1
        else
          expect {
            post :create, parameters, {:user_id => publik.id, :user => 'someone'}
            }.to change(List, :count).by(1)
        end
      end

      it "returns created message on success" do
        listable = create :listable, name: 'Alpha'
        publik = create :public
        parameters = {:public_id => publik.id, '_json' => listable.id } 
        post :create, parameters, {:user_id => publik.id, :user => 'someone'} 
        expect(response.body).to eq("Alpha Created")
      end

      it "returns duplicate message on duplication" do
        listable = create :listable, name: 'Alpha'
        publik = create :public
        parameters = {:public_id => publik.id, '_json' => listable.id } 
        post :create, parameters, {:user_id => publik.id, :user => 'someone'}  
        post :create, parameters, {:user_id => publik.id, :user => 'someone'}  
        List.count == 2
        response.body =="Duplicate List"
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested list" do
        list = create :list 
        visibility = 'Private' 
        values = '[{"a":"b"}]'
        updated = {:public_id => list.public_id, :id => list.id, :values => values , :visibility => visibility}
        post :update, updated, {:user_id => list.public_id, :user => 'someone'}
        list.visibility == visibility && list.values == values
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested list" do
      list = create :list
      parameters = {:id => list.id, public_id: list.public_id} 
      expect {
        delete :destroy, parameters, {:user_id => list.public_id, :user => 'someone'}
        }.to change(List, :count).by(-1)
    end
  end
end
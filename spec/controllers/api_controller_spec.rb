require 'spec_helper'


describe Apis::ApiController do


  before(:all) do
    require  Rails.root.to_s + '/app/helpers/session_helper.rb'
    application = stormpath_get_application
    account = application.accounts.search('username' => 'apitester').first
    unless account
      account = application.accounts.create({ 
        given_name: 'API',
        surname: 'Tester',
        email: 'apitester@example.com',
        password: 'Aa123456',
        username: 'apitester'
      })

   end
  end
	before(:each) do
    @partner = create :partner, :stormpath_id => 'apitester'   
    @token = create :token, :partner_id => @partner.id, :token_value => 'secret',\
      :last_login => Time.now.utc, :last_activity => Time.now.utc
		request.env['HTTP_AUTHORIZATION'] = \
		  ActionController::HttpAuthentication::Token.encode_credentials(@token.token_value)
	end
  #get "authorize/:key", :to=>'api#authorize'
  describe "GET authorize" do
    it "requires successful authorization" do
      request.env.delete('HTTP_AUTHORIZATION')
      request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("apitester:Aa123456")
      get :authorize, nil, nil, nil
      expect(response.body).not_to eq('unauthorized')
    end
  	it "rejects unsuccessful authorization" do
  		request.env.delete('HTTP_AUTHORIZATION')
      request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("someone:Aa123456")
  		get :authorize, nil, nil, nil
      expect(response.body).to eq('unauthorized')
  	end
  end
  describe "GET partner_apps fails without authorization" do
    it "returns ok" do
      request.env.delete('HTTP_AUTHORIZATION')
      partner_app = create :partner_app
      get :app_publics, {:partner_app_id => partner_app.id }, nil, nil
      expect(response.response_code).to eq(401)
    end
  end
  #get "app_publics/:partner_app_id", :to=>'api#app_publics'
  describe "GET app_publics" do
  	it "returns public users with a partner app" do
      partner_app = create :partner_app, :partner_id => @partner.id
      publics = 5.times.collect { create :public}
      app_of_publics = publics.collect { |publik| create :app_of_public, :public_id => publik.id, :partner_app_id => partner_app.id }
  		get :app_publics, {:partner_app_id => partner_app.id}, nil, nil
  		expect(response.body).to eq(app_of_publics.map{ |x| x.public_id }.uniq.sort.to_json.delete(' '))
  	end
  end
    #get "site_publics/:site", :to=>'api#site_publics'
    describe "GET site_publics" do
    	it "returns public users with a partner site" do
        partner_site = create :partner_site, :partner_id => @partner.id
        publics = 5.times.collect { create :public }
        site_of_publics = publics.collect { |publik| create :site_of_public, :public_id => publik.id, :partner_site_id => partner_site.id }
        get :site_publics, {:partner_site_id => partner_site.id}, nil, nil
        expect(response.body).to eq(site_of_publics.map{ |x| x.public_id }.uniq.sort.to_json.delete(' '))
    	end
    end
    #post "invite/:public_id", :to=>'api#invite'
    describe "POST invite" do
    	it "returns ok if successful" do
        invite = build :invitation, :partner_id => @partner_id
    		post :invite, invite.attributes, nil, nil
    		expect(response.body).to eq('ok')
    	end
      it "adds an invitation for a public user" do
        invite = build :invitation, :partner_id => @partner_id
        expect {
          post :invite, invite.attributes, nil, nil
        }.to change(Invitation, :count).by(1)
      end
    end
  #post "offer/:public_id", :to=>'api#offer'
  describe "POST offer" do
    it "returns ok if successful" do
        offer = build :offer, :partner_id => @partner_id
        post :offer, offer.attributes, nil, nil
        expect(response.body).to eq('ok')
    end
  	it "adds an offer for a public user" do
        offer = build :offer, :partner_id => @partner_id
        expect {
          post :offer, offer.attributes, nil, nil
        }.to change(Offer, :count).by(1)
  	end
  end
    #post "update/:public", :to=>'api#update'
    describe "POST update" do
      it "returns ok if successful" do
        update = build :update, :partner_id => @partner_id
        post :update, update.attributes, nil, nil
        expect(response.body).to eq('ok')
      end
    	it "adds an update for a public user" do
        update = build :update, :partner_id => @partner_id
        post :update, update.attributes, nil, nil
        expect {
          post :update, update.attributes, nil, nil
        }.to change(Update, :count).by(1)
    	end
    end
    #get "lists/:listable_id" , :to=>'api#lists'
    describe "GET lists" do
    	it "returns all the lists for a listable" do
        listable = create :listable, :name => 'wines'
        lists = 5.times.collect { create :list, :name => listable.name }
    		get :lists, {:listable_id => listable.id}, nil, nil
    		expect(response.body).to eq(lists.to_json)
    	end
    end
    #get "list/:list_id", :to=>'api#list'
    describe "GET list" do
    	it "returns the details of a specific list" do
        list = create :list
    		get :list, {:list_id => list.id}, nil, nil
    		expect(response.body).to eq(list.to_json)
    	end
    end
	#get "publics/:public_id", :to=>'api#publics'
	describe "GET publics" do
		it "returns the details of a public user" do
      publik = create :public
			get :publics, {:public_id => publik.id}, nil, nil
			expect(response.body).to eq(publik.to_json)
		end
	end
	#get "publics/:public_id/list_id/:list_id", :to=>'api#publics'
	describe "GET publics/list" do
		it "returns a specific list of a public user" do
      list = create :list
			get :publics_list, {:public_id => list.public_id, :list_id => list.id}, nil, nil
			expect(response.body).to eq(list.to_json)
		end
	end
	#get "publics/:public_id/lists", :to=>'api#publics'
	describe "GET publics/lists" do
		it "returns the list names and ids of a public user" do
      publik = create :public
      lists =  2.times.collect { create :list, :public_id => publik.id }
			get :publics_lists, {:public_id => publik.id}, nil, nil
			expect(response.body).to eq(lists.collect{|list| [ list.id, list.name]}.to_json)
		end
	end
    #get "adieu", :to=>'api#adieu
    describe "GET adieu" do
      it "returns adieu" do
        get :adieu, nil, nil, nil
        expect(response.body).to eq('adieu')
      end
    	it "ends an authentication token" do
    		get :adieu, nil, nil, nil
    		expect(Token.find_by_id(@token.id)).to eq(nil)
    	end
    end
end

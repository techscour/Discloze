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
   #@token = "secret"
  end
	before(:each) do
    @partner = Partner.create :stormpath_id => 'apitester'   
    @token = Token.create :partner_id => @partner.id, :token_value => 'secret',\
      :last_login => Time.now.utc, :last_activity => Time.now.utc
		request.env['HTTP_AUTHORIZATION'] = \
		  ActionController::HttpAuthentication::Token.encode_credentials(@token.token_value)
	end
  #describe "Factory Girl Test" do
    #it "builds a listable" do
      #a = FactoryGirl.build :listable
    #end
  #end
  #get "authorize/:key", :to=>'api#authorize'
  describe "GET authorize" do
  	it "not unauthorized" do
  		request.env.delete('HTTP_AUTHORIZATION')
      request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("apitester:Aa123456")
  		get :authorize, {:key => 1}, nil, nil
      @token = response.body
  		@token.should_not == 'unauthorized'
  	end
  end
  describe "GET partner_apps fails without authorization" do
    it "returns ok" do
      request.env.delete('HTTP_AUTHORIZATION')
      partner_app = PartnerApp.create!
      get :app_publics, {:partner_app_id => partner_app.id }, nil, nil
      response.response_code.should == 401
    end
  end
  #get "app_publics/:partner_app_id", :to=>'api#app_publics'
  describe "GET app_publics" do
  	it "returns public users with a partner app" do
      partner_app = PartnerApp.create! :partner_id => @partner.id
      publics = 5.times.collect { Public.create! }
      app_of_publics = publics.collect { |publik| AppOfPublic.create :public_id => publik.id, :partner_app_id => partner_app.id }
  		get :app_publics, {:partner_app_id => partner_app.id}, nil, nil
  		response.body.should == app_of_publics.map{ |x| x.public_id }.uniq.sort.to_json.delete(' ')
  	end
  end
    #get "site_publics/:site", :to=>'api#site_publics'
    describe "GET site_publics" do
    	it "returns public users with a partner site" do
        partner_site = PartnerSite.create! :partner_id => @partner.id
        publics = 5.times.collect { Public.create! }
        site_of_publics = publics.collect { |publik| SiteOfPublic.create :public_id => publik.id, :partner_site_id => partner_site.id }
        get :site_publics, {:partner_site_id => partner_site.id}, nil, nil
        response.body.should == site_of_publics.map{ |x| x.public_id }.uniq.sort.to_json.delete(' ')
    	end
    end
    #post "invite/:public_id", :to=>'api#invite'
    describe "POST invite" do
    	it "adds an invitation for a public user" do
        publik = Public.create
        invite = Invitation.create! :public_id => publik.id, :partner_id => @partner_id
    		post :invite, {:public_id => publik.id}, nil, nil
    		response.body.should == 'ok'
    	end
    end
  #post "offer/:public_id", :to=>'api#offer'
  describe "POST offer" do
  	it "adds an offer for a public user" do
        publik = Public.create
        invite = Offer.create! :public_id => publik.id, :partner_id => @partner_id
        post :offer, {:public_id => publik.id}, nil, nil
        response.body.should == 'ok'
  	end
  end
    #post "update/:public", :to=>'api#update'
    describe "POST update" do
    	it "adds an update for a public user" do
        publik = Public.create
        invite = Update.create! :public_id => publik.id, :partner_id => @partner_id
        post :update, {:public_id => publik.id}, nil, nil
        response.body.should == 'ok'
    	end
    end
    #get "lists/:listable_id" , :to=>'api#lists'
    describe "GET lists" do
    	it "returns all the lists for a listable" do
        listable = Listable.create :name => 'wines'
        lists = 5.times.collect { List.create! :name => listable.name }
    		get :lists, {:listable_id => listable.id}, nil, nil
    		response.body.should == lists.to_json
    	end
    end
    #get "list/:list_id", :to=>'api#list'
    describe "GET list" do
    	it "returns the details of a specific list" do
        list = List.create!
    		get :list, {:list_id => list.id}, nil, nil
    		response.body.should == list.to_json
    	end
    end
	#get "publics/:public_id", :to=>'api#publics'
	describe "GET publics" do
		it "returns the details of a public user" do
      publik = Public.create!
			get :publics, {:public_id => publik.id}, nil, nil
			response.body.should == publik.to_json
		end
	end
	#get "publics/:public_id/list_id/:list_id", :to=>'api#publics'
	describe "GET publics/list" do
		it "returns a specific list of a public user" do
      publik = Public.create!
      list = List.create! :public_id => publik.id
			get :publics_list, {:public_id => publik.id, :list_id => list.id}, nil, nil
			response.body.should ==  list.to_json
		end
	end
	#get "publics/:public_id/lists", :to=>'api#publics'
	describe "GET publics/lists" do
		it "returns the list names and ids of a public user" do
      publik = Public.create!
      lists =  2.times.collect { List.create! :public_id => publik.id }
			get :publics_lists, {:public_id => publik.id}, nil, nil
			response.body.should == lists.collect{|list| [ list.id, list.name]}.to_json
		end
	end
    #get "adieu", :to=>'api#adieu
    describe "GET adieu" do
    	it "ends an authentication token" do
    		get :adieu, nil, nil, nil
        token =  
    		response.body.should == 'adieu'
    	end
    end
end

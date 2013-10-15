class Apis::ApiController < ActionController::Base
	before_action :authenticate_token, except: [ :authorize ]
	respond_to :json

	#get "app_publics/:partner_app_id", :to=>'api#app_publics'
	def app_publics
		app = PartnerApp.find_by_id(params['partner_app_id']) 
		unless app && app.partner_id == @partner_id 
			render :json => 'not found' , :status => :not_found
			return
		end
		render :json => AppOfPublic.where(:partner_app_id => app.id).distinct.pluck('public_id').sort
	end

	#get "site_publics/:site_id", :to=>'api#site_publics'
	def site_publics

		site = PartnerSite.find_by_id(params['partner_site_id']) 
		unless site && site.partner_id == @partner_id 
			render :json => 'not found' , :status => :not_found
			return
		end
		render :json => SiteOfPublic.where(:partner_site_id => site.id).distinct.pluck('public_id').sort
	end

	#post "invite/:public_id", :to=>'api#invite'
	def invite
		publik = Public.find_by_id(params['public_id'])
		unless publik
			render :json => 'not found' , :status => :not_found
			return
		end
		params['partner_id'] = @partner_id
		Invitation.create! params.select {|k,v| %w{public_id partner_id headline list html posted expires effective}.include? k}
		render :json => "ok"
	end

	#post "offer/:public_id", :to=>'api#offer'
	def offer
		publik = Public.find_by_id(params['public_id'])
		unless publik
			render :json => 'not found' , :status => :not_found
			return
		end
		params['partner_id'] = @partner_id
		Offer.create! params.select {|k,v| %w{public_id partner_id headline list html posted expires effective}.include? k}
		render :json => "ok"
	end

	#post "update/:public_id", :to=>'api#update'
	def update
		publik = Public.find_by_id(params['public_id'])
		unless publik
			render :json => 'not found' , :status => :not_found
			return
		end
		params['partner_id'] = @partner_id
		Update.create! params.select {|k,v| %w{public_id partner_id headline list html posted expires effective}.include? k}
		render :json => "ok"
	end

	#get "lists/:listable_id" , :to=>'api#lists'
	def lists
		listable = Listable.find_by_id(params['listable_id'])
		unless listable
			render :json => 'not found' , :status => :not_found
			return
		end
		lists = List.where :name => listable.name	
		render :json => lists.to_json
	end

	#get "list/:list_id", :to=>'api#list'
	def list
		list = List.find_by_id(params['list_id'])
		if list	
			render :json => list
		else
			render :json => 'not found' , :status => :not_found
		end
	end

	#get "publics/:public_id", :to=>'api#publics'
	def publics
		publik = Public.find_by_id(params['public_id'])
		if publik
			render :json => publik 
		else
			render :json => 'not found' , :status => :not_found
		end
	end

	#get "publics/:public_id/list/:list_id", :to=>'api#publics'
	def publics_list
		publik = Public.find_by_id(params['public_id'])
		list = List.find_by_id(params['list_id'])
		if publik && list && list.public_id == publik.id
			render :json => list
		else
			render :json => 'not found' , :status => :not_found
		end
	end

	#get "publics_lists/:public_id/lists_id", :to=>'api#publics'
	def publics_lists
		publik = Public.find_by_id(params['public_id'])
		if publik
			render :json => List.where(:public_id => params['public_id']).order('name asc').pluck('id','name').to_json
		else
			render :json => 'not found' , :status => :not_found
		end
	end	

	#get "authorize", :to=>'api#authorize'
	def authorize
	  authenticate_or_request_with_http_basic do |username, password|
	      if stormpath_authenticate_login(username, password) == true
	      	@partner = Partner.find_or_create_by stormpath_id: username
	      	key = generate_token
	      	token = Token.create! :partner_id => @partner.id, :token_value => key, :last_login => Time.now.utc, :last_activity => Time.now.utc
	      	render :json => key
	      else
	      	render :json => 'unauthorized'
	      end
	  end
	end

	#get "adieu", :to=>'api#adieu'
	def adieu
		render :json => "adieu"
	  	authenticate_or_request_with_http_token do |token, options|
	  		token = Token.find_by_token_value token
	  		token.destroy if token
	  		true
	  	end
	end
	private

	def generate_token
		a = ActiveSupport::KeyGenerator.new 'lskdkdididiskj'
		key = a.generate_key 'lkejekdsduuwujjdsu'
		Base64::encode64 key
	end
	def authenticate_token
	  authenticate_or_request_with_http_token do |token_received, options|
	  	token = Token.find_by token_value: token_received
	  	@partner_id = token.partner_id
	  	if token
	  		if token.last_activity < Time.now.utc - 5.minutes
	  			token.destroy
	  			return false
	  		else
 	  			token.last_activity = Time.now.utc
 	  			return true
 	  		end
 	  	else
 	  		return false
 	  	end
	  end
	end
end
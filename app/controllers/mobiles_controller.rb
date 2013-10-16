class MobilesController < ActionController::Base

  	include SessionHelper 
	def landing
		render :mobile
	end

	def login
		authorized = stormpath_authenticate_login params['email'], params['password']
    	if authorized == true
      		publik = Public.find_or_create_by(stormpath_id: session[:user])
      		publik.last_login = Time.now.utc
      		session[:user_id] = publik.id
			render :json => publik.id
		else
		  render :json => false
		end
	end

	def lists
		if session[:user]
			render :json => List.where(:public_id => session[:user_id]) 
		else
			render :json => 'unauthorized'	, :status => :unauthorized
		end
	end

	def list
		if session[:user]
			render :json => List.where(:id => params['list_id']).to_json
		else
			render :json => 'unauthorized'	, :status => :unauthorized
		end
	end
	
	def logout
		reset_session
		redirect_to mobiles_landing_url
	end
end

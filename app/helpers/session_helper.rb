module SessionHelper

	def stormpath_get_application
		key = Stormpath::ApiKey.new(ENV['spkey1'],ENV['spkey2'])
		client = Stormpath::Client.new({:api_key => key})
		return client.applications.get(ENV['spurl'])
	end

	def stormpath_authenticate_login (name, password)
		begin
			application = stormpath_get_application
			auth_request = Stormpath::Authentication::UsernamePasswordRequest.new name, password
			auth_result = application.authenticate_account auth_request
			account = auth_result.account
			session[:user] = account.username
			return true
		rescue => error
			return error.to_s
		end
	end

	def stormpath_get_account
		application = stormpath_get_application
		user = session[:user]
		found = application.accounts.search('username' => user)
		return found.map{|x| x}.first
	end

	def stormpath_update_account params
		begin
			stormpath_get_account.tap do |s|
			  s.email = params['email'],
			  s.surname = params['last'],
			  s.given_name = params['first'],
			  s.save
			end
			return true
		rescue => error
			return error.to_s
		end
	end
	def stormpath_change_password older, newer
		begin
			authentic = stormpath_authenticate_login session['user'], older
			return authentic if authentic != true
			account = stormpath_get_account	
			account.password = newer
			account.save
			return true
		rescue => error
			return error.to_s
		end
	end

	def stormpath_delete_account
		account = stormpath_get_account	
		account.delete
	end

	def stormpath_create_account params
		application = stormpath_get_application
		begin
			account = application.accounts.create({ 
			  given_name: params['first'],
			  surname: params['last'],
			  email: params['email'],
			  password: params['pass1'],
			  username: params['user']
			})
			#no need for save
			return true
		rescue => error
			return error.to_s
		end
	end

	def stormpath_request_password_reset params
		application = stormpath_get_application
		begin
			application.send_password_reset_email params['email']
			return true
		rescue => error
			return error.to_s
		end
	end

	def stormpath_handle_password_reset token
	end

	def stormpath_handle_new_account_confirm token
	end

end

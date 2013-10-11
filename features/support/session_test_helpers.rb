
module SessionHelpers
	def sign_in
		visit '/session/signin'
		fill_in 'email', :with => 'jdoe@example.com'
		fill_in 'password', :with => 'Aa123456'
		click_button 'Sign In'
	end
	def ensure_no_test_account
		begin
			application = stormpath_get_application
			found = application.accounts.search('username' => 'jdoe')
			found.map{|x| x}.first.delete
		rescue
		end
	end
	def fill_in_sign_up
		fill_in 'user', :with => 'jdoe'
		fill_in 'email', :with => 'jdoe@example.com'
		fill_in 'first', :with => 'John'
		fill_in 'last', :with => 'Doe'
		fill_in 'pass1', :with => 'Aa123456'
		fill_in 'pass2', :with => 'Aa123456'
		check 'agree'
	end

	def fill_in_update
		fill_in 'email', :with => 'jdoe@example.com'
		fill_in 'first', :with => 'John'
		fill_in 'last', :with => 'Doe'
	end

	def fill_in_passup
		fill_in 'old', :with => 'Aa123456'
		fill_in 'new1', :with => 'Aa123456'
		fill_in 'new2', :with => 'Aa123456'
	end

	def fill_in_preset
		fill_in 'email', :with => 'jdoe@example.com'
	end
end
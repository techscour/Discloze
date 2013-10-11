class Partner < ActiveRecord::Base
	has_many :partner_sites
	has_many :partner_apps
	has_many :tokens

end

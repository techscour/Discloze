class Partner < ActiveRecord::Base
	has_many :partner_sites, :dependent => :delete_all
	has_many :partner_apps, :dependent => :delete_all
	has_many :tokens, :dependent => :delete_all
end

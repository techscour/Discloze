class Public < ActiveRecord::Base
  has_many :partner_apps, :through => :app_of_public
  has_many :partner_sites, :through => :site_of_public
  has_many :app_of_publics
  has_many :site_of_publics
  has_many :lists
  has_many :notices
  has_many :offers
  has_many :updates
  has_many :lists
  has_many :invitations
  has_many :logins
end

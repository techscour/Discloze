class Public < ActiveRecord::Base
  has_many :partner_apps, :through => :app_of_public
  has_many :partner_sites, :through => :site_of_public
  has_many :app_of_publics, :dependent => :delete_all
  has_many :site_of_publics, :dependent => :delete_all
  has_many :lists, :dependent => :delete_all
  has_many :notices, :dependent => :delete_all
  has_many :offers, :dependent => :delete_all
  has_many :updates, :dependent => :delete_all
  has_many :lists, :dependent => :delete_all
  has_many :invitations, :dependent => :delete_all
  has_many :logins, :dependent => :delete_all
  validates :stormpath_id, :last_login, presence: true
end

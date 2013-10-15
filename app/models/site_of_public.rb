class SiteOfPublic < ActiveRecord::Base
  belongs_to :public
  belongs_to :partner_site
  validates :public_id, :partner_site_id, presence: true
end

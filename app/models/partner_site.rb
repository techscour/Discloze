class PartnerSite < ActiveRecord::Base
  belongs_to :partner
  has_many :site_of_public
  has_many :public, :through => :site_of_public
  validates :partner_id, :name, :description, :url, :html, presence: true
end

class PartnerApp < ActiveRecord::Base
  belongs_to :partner
  has_many :public, :through => :site_of_public
end

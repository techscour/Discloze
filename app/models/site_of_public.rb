class SiteOfPublic < ActiveRecord::Base
  belongs_to :public
  belongs_to :partner_site

end

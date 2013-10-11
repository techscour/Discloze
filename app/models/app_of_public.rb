class AppOfPublic < ActiveRecord::Base
  belongs_to :public
  belongs_to :partner_app

end

class AppOfPublic < ActiveRecord::Base
  belongs_to :public
  belongs_to :partner_app
  validates :public_id, :partner_app_id, presence: true
end

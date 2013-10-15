class Token < ActiveRecord::Base
  belongs_to :partner
  validates :partner_id, :token_value, :last_login, :last_activity, presence: true
end

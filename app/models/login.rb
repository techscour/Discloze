class Login < ActiveRecord::Base
  belongs_to :public
  validates :public_id, :last_activity, :remember, presence: true
end

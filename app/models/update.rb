class Update < ActiveRecord::Base
  belongs_to :public
  belongs_to :partner
  validates :public_id, :partner_id, :list, :headline, :html, :posted, :effective, :expires, presence: true
end

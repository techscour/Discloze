class Invitation < ActiveRecord::Base
  belongs_to :public
  belongs_to :partner
  validates :public_id, :partner_id, :headline, :list, :html, :posted, :effective, :expires, presence: true
end

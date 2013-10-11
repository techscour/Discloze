class Invitation < ActiveRecord::Base
  belongs_to :public
  belongs_to :partner
  scope :browsable, -> { select('headline, list, html, posted, id, partner.name') }
end

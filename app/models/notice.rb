class Notice < ActiveRecord::Base
  belongs_to :public
  scope :browsable, -> { select('headline, html, posted, id') }
end

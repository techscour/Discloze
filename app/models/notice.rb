class Notice < ActiveRecord::Base
  belongs_to :public
  validates :public_id, :headline, :html, :posted, presence: true
end

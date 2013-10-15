class List < ActiveRecord::Base
  belongs_to :public
  validates :public_id, :name, :visibility, :values, :last_activity, :created, presence: true
end

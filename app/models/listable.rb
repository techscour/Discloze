class Listable < ActiveRecord::Base
	scope :browsable, -> { select('name, topic, id') }
end

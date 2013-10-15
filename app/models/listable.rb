class Listable < ActiveRecord::Base
	validates :name, :topic, :description, :html, presence: true
end

class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :stormpath_id
      t.string :name
      t.string :description
      t.string :url
	    t.string :html
    end
  end
end

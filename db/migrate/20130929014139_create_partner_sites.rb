class CreatePartnerSites < ActiveRecord::Migration
  def change
    create_table :partner_sites do |t|
      t.references :partner, index: true
      t.string :name
      t.string :description
      t.string :url
      t.text :html
    end
  end
end

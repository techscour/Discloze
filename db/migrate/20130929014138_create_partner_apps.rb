class CreatePartnerApps < ActiveRecord::Migration
  def change
    create_table :partner_apps do |t|
      t.references :partner, index: true
      t.string :name
      t.string :description
      t.string :url
      t.text :html
      t.timestamps
    end
  end
end

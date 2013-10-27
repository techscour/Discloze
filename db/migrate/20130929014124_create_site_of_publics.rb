class CreateSiteOfPublics < ActiveRecord::Migration
  def change
    create_table :site_of_publics do |t|
      t.references :public, index: true
      t.references :partner_site, index: true
    end
  end
end

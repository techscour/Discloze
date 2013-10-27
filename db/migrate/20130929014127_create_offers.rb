class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :public, index: true
      t.references :partner, index: true
      t.string :list
      t.string :headline
      t.text :html
      t.datetime :posted
      t.datetime :effective
      t.datetime :expires
    end
  end
end

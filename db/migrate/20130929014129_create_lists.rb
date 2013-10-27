class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.references :public, index: true
      t.string :name
      t.string :visibility
      t.text :values
      t.datetime :last_activity
      t.datetime :created
    end
  end
end

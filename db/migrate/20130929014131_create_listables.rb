class CreateListables < ActiveRecord::Migration
  def change
    create_table :listables do |t|
      t.string :name
      t.string :topic
      t.string :description
      t.text :html
      t.timestamps
    end
  end
end

class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.references :public, index: true
      t.string :headline
      t.text :html
      t.datetime :posted

      t.timestamps
    end
  end
end

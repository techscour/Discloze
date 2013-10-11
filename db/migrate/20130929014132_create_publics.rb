class CreatePublics < ActiveRecord::Migration
  def change
    create_table :publics do |t|
      t.string :stormpath_id
      t.datetime :last_login

      t.timestamps
    end
  end
end

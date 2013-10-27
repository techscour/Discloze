class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.references :public, index: true
      t.datetime :last_activity
      t.boolean :remember
    end
  end
end

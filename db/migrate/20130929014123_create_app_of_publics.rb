class CreateAppOfPublics < ActiveRecord::Migration
  def change
    create_table :app_of_publics do |t|
      t.references :public, index: true
      t.references :partner_app, index: true

      t.timestamps
    end
  end
end

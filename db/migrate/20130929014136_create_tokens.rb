class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.references :partner, index: true
      t.string :token_value
      t.datetime :last_login
      t.datetime :last_activity
    end
  end
end

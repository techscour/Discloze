class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :public, index: true
      t.references :partner, index: true
      t.string :headline
      t.string :list
      t.text :html
      t.datetime :posted
      t.datetime :effective
      t.datetime :expires
    end
  end
end

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :gender
      t.string :type
      t.string :password_digest
      t.string :activation_digest
      t.string :remember_digest
      t.string :reset_digest
      t.boolean :activated_account
      t.datetime :activated_account_at
      t.datetime :reset_sent_at
      t.boolean :blocked_activity

      t.timestamps
    end
    add_index :users, :email
  end
end

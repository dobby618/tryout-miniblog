# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :name,               null: false, default: ''
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Profile
      t.string :profile
      t.text   :url

      t.timestamps null: false
    end

    add_index :users, :name, unique: true
  end
end

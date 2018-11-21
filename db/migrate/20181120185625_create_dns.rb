# frozen_string_literal: true

class CreateDns < ActiveRecord::Migration[5.2]
  def change
    create_table :dns do |t|
      t.string :ip
      t.string :domains, array: true, default: []

      t.timestamps
    end
  end
end

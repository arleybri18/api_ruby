class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :url
      t.references :step, null: false, foreign_key: true

      t.timestamps
    end
  end
end

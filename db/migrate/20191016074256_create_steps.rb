class CreateSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.string :name
      t.string :info_step
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end

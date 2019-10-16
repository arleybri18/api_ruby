class CreateExecutions < ActiveRecord::Migration[6.0]
  def change
    create_table :executions do |t|
      t.integer :state
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end

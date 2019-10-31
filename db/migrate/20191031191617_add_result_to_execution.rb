class AddResultToExecution < ActiveRecord::Migration[6.0]
  def change
    add_column :executions, :result, :text
  end
end

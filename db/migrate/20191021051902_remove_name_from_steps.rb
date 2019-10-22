class RemoveNameFromSteps < ActiveRecord::Migration[6.0]
  def change

    remove_column :steps, :name, :string
  end
end

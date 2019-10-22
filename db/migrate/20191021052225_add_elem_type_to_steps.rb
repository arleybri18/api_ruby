class AddElemTypeToSteps < ActiveRecord::Migration[6.0]
  def change
    add_column :steps, :elem_type, :string
    add_column :steps, :name_elem, :string
    add_column :steps, :elem_action, :string
  end
end

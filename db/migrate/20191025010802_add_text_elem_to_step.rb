class AddTextElemToStep < ActiveRecord::Migration[6.0]
  def change
    add_column :steps, :text_elem, :string
  end
end

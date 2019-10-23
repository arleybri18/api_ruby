class RemoveStepFromPages < ActiveRecord::Migration[6.0]
  def change
    remove_reference :pages, :step, null: false, foreign_key: true
  end
end

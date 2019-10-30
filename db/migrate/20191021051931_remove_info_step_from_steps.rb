class RemoveInfoStepFromSteps < ActiveRecord::Migration[6.0]
  def change

    remove_column :steps, :info_step, :string
  end
end

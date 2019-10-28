class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    if table_exists?(:users)
      puts "exists"
    else
      create_table :users do |t|

        t.timestamps
      end
    end

  end
end

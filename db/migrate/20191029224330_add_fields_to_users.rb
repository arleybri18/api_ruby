class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:users, :fullname)
      add_column :users, :fullname, :string
    end
    unless column_exists?(:users, :email)
      add_column :users, :email, :string
    end
    unless column_exists?(:users, :password_digest)
      add_column :users, :password_digest, :string
    end    
    unless column_exists?(:users, :enabled)
      add_column :users, :enabled, :integer
    end
  end
end

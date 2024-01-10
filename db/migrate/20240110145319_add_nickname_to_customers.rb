class AddNicknameToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :nick_name, :string
  end
end

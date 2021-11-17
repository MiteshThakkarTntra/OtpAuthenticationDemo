class ChangeDataTypeInPhoneNumber < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :phone_number, :bigint
  end
end

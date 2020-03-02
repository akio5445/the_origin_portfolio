class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    # user.toggle!(:admin), ser.admin?
    add_column :users, :admin, :boolean, default: false
  end
end

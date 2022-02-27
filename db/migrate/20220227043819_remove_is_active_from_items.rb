class RemoveIsActiveFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :is_active, :boolean
    remove_column :order_details, :making_status, :integer
    remove_column :orders, :status, :integer
    remove_column :orders, :payment_method, :integer
  end
end

class AddAssigneeToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :assignee_id, :integer
  end
end

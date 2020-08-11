class CreateTicketTags < ActiveRecord::Migration[6.0]
  def change
    create_table :ticket_tags do |t|
      t.belongs_to :ticket
      t.belongs_to :tag
      t.timestamps
    end
  end
end

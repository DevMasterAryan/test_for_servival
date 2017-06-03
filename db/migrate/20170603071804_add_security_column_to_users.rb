class AddSecurityColumnToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :security_question, :integer
  	add_column :users, :security_answer, :string
  end
end

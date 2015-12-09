class CreateAccounts < ActiveRecord::Migration
   def change
     create_table :accounts do |t|
       t.string :name
       t.text :password_hash
     end
   end
end

class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.timestamps
      # klienta_vārds
      t.string(:first_name, null:false, default:"")
      # klienta uzvārds
      t.string(:last_name, null:false, default:"")
      # klienta numurs
      t.string(:phone_prefix, null:false, default:"")
      t.string(:phone_number, null:false, default:"")
      # klienta epasts
      t.string(:email, null:false, default:"")
    end

    add_index(
      :clients, 
      [:first_name, :last_name, :phone_prefix, :phone_number],
      unique: true, name:"client_uniqueness_index"
    ) 
    
    add_index(:clients, :last_name)
    add_index(:clients, :phone_prefix)
    add_index(:clients, :phone_number)
    add_index(:clients, :email)
  end
end

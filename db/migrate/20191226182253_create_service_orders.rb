class CreateServiceOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :service_orders do |t|
      t.timestamps

      # numurs
      t.string(:number, null:false, default:"")
      # pieņemšanas datums
      t.date(:date, null:false)
      # pieņemšanas vieta # vietas_id
      t.string(:location, null:false, default:"")
      # pieņēmējs  (user_id)
      t.integer(:user_id, null:false)


      # klienta_vārds
      #t.string(:client_name, null:false, default:"")
      # klienta uzvārds
      # klienta numurs
      # klienta epasts
      t.integer(:client_id, null:false)

      # iekārtas veids
      t.string(:device_name, null:false)
      # iekārtas parole
      t.string(:device_password)
      # iekārtas garantija BOOLEAN
      t.boolean(:device_warranty, null:false, default:false)
      # iekārtas papildaprīkojums TEXT
      t.text(:device_extras, null:false, default:"")
      # iekārtas saglabājamā info
      t.text(:device_saveable_info, null:false, default:"")
      # iekārtas defekta apraksts
      t.text(:device_defect, null:false, default:"")
      # papildus info (par iekārtu) TEXT
      t.text(:device_additional_info, null:false, default:"")
    end
    add_index(:service_orders, :number)  
    add_index(:service_orders, :date)
    add_index(:service_orders, :location) 
    add_index(:service_orders, :user_id) 
    add_index(:service_orders, :client_id) 
    add_index(:service_orders, :device_name) 
  end
end

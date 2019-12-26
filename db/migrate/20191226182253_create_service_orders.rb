class CreateServiceOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :service_orders do |t|
      t.timestamps

      # numurs
      # pieņemšanas datums
      # pieņemšanas vieta # vietas_id
      # pieņēmējs  (user_id)

      # klienta_vārds
      # klienta uzvārds
      # klienta numurs
      # klienta epasts

      # iekārtas veids
      # iekārtas parole
      # iekārtas garantija BOOLEAN
      # iekārtas papildaprīkojums TEXT
      # iekārtas saglabājamā info
      # iekārtas defekta apraksts
      # papildus info (par iekārtu) TEXT

      # t.

    end
  end
end

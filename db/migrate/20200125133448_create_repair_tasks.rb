class CreateRepairTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :repair_tasks do |t|
      t.timestamps

      t.integer(:repairer_id, null: false)
      t.integer(:service_order_id, null: false)
      t.integer(:status, null: false, default: 0)
      t.string(:currency, null: false)
      t.integer(:work_cost_cents, null: false, default: 0)
      t.integer(:materials_cost_cents, null: false, default: 0)
      t.string(:repaired, null: false)
    end

    add_index(:repair_tasks, :repairer_id)
    add_index(:repair_tasks, :status)
  end
end

# manufacturing_erp/app/models/production_line.rb
class ProductionLine < ApplicationRecord
  has_many :equipment, dependent: :destroy
  has_many :quality_checks, dependent: :destroy
  has_many :alerts, dependent: :destroy
  has_many :sensor_data, dependent: :destroy
  
  validates :name, presence: true
  validates :capacity, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: %w[active inactive maintenance] }
  
  after_update_commit :broadcast_status_change
  
  private
  
  def broadcast_status_change
    ActionCable.server.broadcast "production_status", {
      id: id,
      name: name,
      status: status,
      efficiency: efficiency,
      current_output: current_output,
      updated_at: updated_at
    }
  end
end

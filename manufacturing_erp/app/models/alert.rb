# manufacturing_erp/app/models/alert.rb
class Alert < ApplicationRecord
  belongs_to :production_line, optional: true
  belongs_to :equipment
  
  validates :alert_type, :severity, :message, :status, presence: true
  
  after_create_commit :broadcast_alert
  after_update_commit :broadcast_alert_update
  
  private
  
  def broadcast_alert
    ActionCable.server.broadcast "production_status", {
      type: "alert",
      alert: {
        id: id,
        alert_type: alert_type,
        severity: severity,
        message: message,
        equipment_id: equipment_id,
        production_line_id: production_line_id,
        triggered_at: triggered_at
      }
    }
  end
  
  def broadcast_alert_update
    ActionCable.server.broadcast "production_status", {
      type: "alert_update",
      alert: attributes
    }
  end
end

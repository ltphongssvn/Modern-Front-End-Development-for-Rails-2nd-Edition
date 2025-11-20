# manufacturing_erp/app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  def index
    @production_lines = ProductionLine.includes(:equipment, :alerts)
    @active_alerts = Alert.where(status: 'active').order(triggered_at: :desc)
    @recent_quality_checks = QualityCheck.order(performed_at: :desc).limit(5)
    @upcoming_maintenance = MaintenanceSchedule.where(status: 'scheduled')
                                               .order(scheduled_date: :asc)
                                               .limit(5)
  end
end

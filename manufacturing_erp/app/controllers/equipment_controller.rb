# manufacturing_erp/app/controllers/equipment_controller.rb
class EquipmentController < ApplicationController
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]
  before_action :set_production_lines, only: [:new, :edit]
  before_action :authorize_edit!, only: [:new, :create, :edit, :update]
  before_action :authorize_delete!, only: [:destroy]

  def index
    @equipment = Equipment.includes(:production_line)
  end

  def show
    @maintenance_schedules = @equipment.maintenance_schedules.order(scheduled_date: :asc)
    @recent_alerts = @equipment.alerts.order(triggered_at: :desc).limit(5)
  end

  def new
    @equipment = Equipment.new
  end

  def edit
  end

  def create
    @equipment = Equipment.new(equipment_params)
    if @equipment.save
      redirect_to @equipment, notice: 'Equipment was successfully created.'
    else
      set_production_lines
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @equipment.update(equipment_params)
      redirect_to @equipment, notice: 'Equipment was successfully updated.'
    else
      set_production_lines
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @equipment.destroy
    redirect_to equipment_index_url, notice: 'Equipment was successfully destroyed.'
  end

  private

  def set_equipment
    @equipment = Equipment.find(params[:id])
  end

  def set_production_lines
    @production_lines = ProductionLine.all
  end

  def equipment_params
    params.require(:equipment).permit(:name, :serial_number, :production_line_id, :status, 
                                      :last_maintenance, :next_maintenance, :operating_hours)
  end
  
  def authorize_edit!
    redirect_to equipment_index_path, alert: 'Not authorized to edit' unless current_user.can_edit?
  end
  
  def authorize_delete!
    redirect_to equipment_index_path, alert: 'Not authorized to delete' unless current_user.can_delete?
  end
end

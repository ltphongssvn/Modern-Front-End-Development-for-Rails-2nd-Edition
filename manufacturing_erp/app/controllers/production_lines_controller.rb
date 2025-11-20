# manufacturing_erp/app/controllers/production_lines_controller.rb
class ProductionLinesController < ApplicationController
  before_action :set_production_line, only: [:show, :edit, :update, :destroy]

  def index
    @production_lines = ProductionLine.all
  end

  def show
    @equipment = @production_line.equipment
    @recent_alerts = @production_line.alerts.order(triggered_at: :desc).limit(5)
  end

  def new
    @production_line = ProductionLine.new
  end

  def edit
  end

  def create
    @production_line = ProductionLine.new(production_line_params)
    if @production_line.save
      redirect_to @production_line, notice: 'Production line was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @production_line.update(production_line_params)
      redirect_to @production_line, notice: 'Production line was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @production_line.destroy
    redirect_to production_lines_url, notice: 'Production line was successfully destroyed.'
  end

  private

  def set_production_line
    @production_line = ProductionLine.find(params[:id])
  end

  def production_line_params
    params.require(:production_line).permit(:name, :status, :capacity, :current_output, :efficiency, :location)
  end
end

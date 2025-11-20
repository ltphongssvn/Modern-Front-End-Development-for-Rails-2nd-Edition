# manufacturing_erp/app/controllers/api/production_lines_controller.rb
module Api
  class ProductionLinesController < ApplicationController
    def index
      @production_lines = ProductionLine.includes(:equipment, :alerts)
      render json: @production_lines.map { |line|
        {
          id: line.id,
          name: line.name,
          status: line.status,
          capacity: line.capacity,
          currentOutput: line.current_output,
          efficiency: line.efficiency,
          equipment: line.equipment.map { |e|
            {
              id: e.id,
              name: e.name,
              status: e.status
            }
          }
        }
      }
    end
  end
end

# manufacturing_erp/app/channels/production_status_channel.rb
class ProductionStatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from "production_status"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

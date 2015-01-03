class QrController < ApplicationController
  def index
    table = params[:qr_code]
    @qr = RQRCode::QRCode.new(request.host + '/menu/' + table, :size => 8)
    
    render:layout => false
  end
end
require "ipaddr"

class BlacklistConstraint
  def initialize
    obj = AllowedIp.first
    @from = obj.from
    @to = obj.to
  end

  def matches?(request)
    p "**********************"
    p "im here.. my ip is #{request.remote_ip}.."
    
    low = IPAddr.new(@from).to_i
    high = IPAddr.new(@to).to_i
    ip = IPAddr.new(request.remote_ip).to_i
    
    p "..and the result is..#{(low..high)===ip}"
    false
  end
end

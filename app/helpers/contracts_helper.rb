module ContractsHelper

  def recruit_ter(obj,i)
    out = (obj.send(i).map &:name).join(', ') rescue nil
    "<li><label>#{i.titleize}</label>: #{ out }</li>".html_safe
  end
  
  def prep_pre(obj)
    out = {}
    
    %w(all_prohibited_countries all_permitted_countries 
       all_prohibited_regions all_permitted_regions).each do |elem|
       
       out[elem.to_sym] = obj.object.send(elem).map {|i| {id: i.id,name: i.name }}
    
    end
    
    out
  end
  
end

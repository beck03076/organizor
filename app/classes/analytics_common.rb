module AnalyticsCommon

  def qualify_period_size(records,conditions,count = true,limit = true)
  	if !conditions[:last_months].blank? 
  	  out = records.where("DATE(#{@core}.created_at) > CURDATE() - INTERVAL #{conditions[:last_months]} MONTH")
  	elsif !conditions[:from].blank? && !conditions[:to].blank?
      out = records.where("DATE(#{@core}.created_at) BETWEEN '#{conditions[:from]}' AND '#{conditions[:to]}' ")
  	else
  	  out = records
  	end
  	temp = limit ? out.limit(conditions[:size].to_i) : out.all
  	final = count ? temp.count.except(0,nil) : temp  	
  	final
  end 

  def fetch_ordered_records(model,includable,ordered_ids,map = true)
    return [] if ordered_ids.blank?

    result = model.constantize.includes(includable).where(id: ordered_ids).order("FIELD(id,#{ordered_ids.join(",")})")

    return result if !map

    result.map{|i| [i.id,i.name,i.ins_type] }
  end
  # ======== Popularity based on Count of all the actions ================
  def actions_counts(conditions)
    # fetching filtered applications 
    filtered = qualify_period_size(sum_and_order_all_actions,conditions,false)
     # returning the output as hash
    {table_header: ["name","total_score","emails_count",
                    "todos_count","follow_ups_count","notes_count"],
     ordered_output: filtered,
     page_header: "#{@title.titleize} Popular <<size>> #{@core.titleize} Based on Actions",
     link_id: :id,
     partial: "duration" }
  end

  def sum_and_order_all_actions
    model = @core.singularize.camelize.constantize
    model.order("(emails_count + todos_count + notes_count + follow_ups_count) #{@data}")
  end
  # =====================================================================
  # ======== Popularity based on Count of all the impressions ================

  def impressions_counts(conditions)
    # fetching filtered applications 
    filtered = qualify_period_size(order_by_impressions,conditions,false)
    p "&&&&&&&&&&&"
    p filtered
     # returning the output as hash
    {table_header: ["name","impressions_count"],
     ordered_output: filtered,
     page_header: "#{@title.titleize} Popular <<size>> #{@core.titleize} Based on Views",
     link_id: :id,
     partial: "duration" }
  end

  def order_by_impressions
    model_name = @core.singularize.camelize
    klass = model_name.constantize
    sorted_ids = Impression.where(impressionable_type: model_name).group(:impressionable_id).count.sort_by{|k,v| v }
    core_ids = sorted_ids.send(@data).map{|i| i[0]}
    klass.where(id: core_ids).order("FIELD(id,#{core_ids.join(",")})")
  end


  # =====================================================================

  # =================
  # = Class Methods =
  # =================
  module ClassMethods 
    def popular_actions(data,conditions,core)
      new(data,core).actions_counts(conditions)    
    end

    def popular_impressions(data,conditions,core)
      new(data,core).impressions_counts(conditions)    
    end
  end

  # ============
  # = Included =
  # ============
  def self.included(base)
    base.extend(ClassMethods)
  end

end
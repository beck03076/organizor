module ActionsModel

  # ============
  # = Included =
  # ============
  def self.included(base)
    base.extend(ClassMethods)
    # ===========
    # = Scoping =
    # ===========
    base.class_eval do
      after_create :increment_counter
      before_destroy :decrement_counter
    end
  end

  # ===========
  # = Methods =
  # ===========
  def increment_counter
    if self.class.name == "Email"
      send(core).each do |core|
        change_count core,:emails_count, &:+
      end
    else
      set_core_obj
      if !@core_name.nil?
        set_col
        change_count @core_obj,@col,&:+
      end
    end
  end

  def decrement_counter
    if self.class.name == "Email"
      send(core).each do |core|
        change_count core,:emails_count, &:-
      end
    else
      set_core_obj
      if !@core_name.nil?
        set_col
        change_count @core_obj,@col,&:-
      end
    end
  end

  def set_core_obj
      @klass = self.class.name.underscore
      @core_name = send((@klass + "able_type").downcase)
      return if @core_name.nil?
      @core_class = @core_name.constantize
      @core_id = send((@klass + "able_id").downcase)
      @core_obj = @core_class.find(@core_id)
  end

  def set_col
    @col = (@klass.pluralize.downcase + "_count").to_sym
  end

  def change_count(core,col)
    current = yield core.send(col),1
    core.update_attribute(col, current)
  end

  def parent
    set_core_obj
    @core_obj
  end

  # =================
  # = Class Methods =
  # =================
  module ClassMethods
  end
end

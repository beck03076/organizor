module Generic
  def model(i)
    i.camelize.constantize
  end
end
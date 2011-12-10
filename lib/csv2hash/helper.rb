class String
  def blank?
    self == ''
  end

  def present?
    self != ''
  end
end

class NilClass
  def blank?
    true
  end

  def present?
    false
  end
end

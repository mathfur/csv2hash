# -*- encoding: utf-8 -*-

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

class CSV2Hash
  def self.accumulate_to_hash(hash, keys, value)
    result = hash.clone
    base = result
    keys.each_with_index do |k, i|
      if i == keys.size - 1
        raise "キーの上書きが発生しました" if result[k]
        result[k] = value
      else
        result[k] ||= {}
        result = result[k]
      end
    end
    base
  end
end

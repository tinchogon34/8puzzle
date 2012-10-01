class DeepClone
  def self.clone(obj)
    Marshal::load(Marshal.dump(obj))
  end
end


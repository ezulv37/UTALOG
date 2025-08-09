module KeyDisplayable
  def key_display
    return "原曲" if self.key.nil?

    if self.key == 0
      "原曲"
    elsif self.key > 0
      "原曲+#{self.key}"
    else
      "原曲#{self.key}"  # keyが-2なら「原曲-2」
    end
  end
end

class Critic < ActiveRecord::Base
  def pct
    ((agree.to_f / (agree + disagree)) * 100).to_i
  end

  def meter_color
    if pct > 75
      "alert"
    elsif pct > 50
      ""
    else
      "success"
    end
  end
end

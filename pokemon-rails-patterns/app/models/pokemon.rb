class Pokemon < ActiveRecord::Base
  self.inheritance_column = nil #Defending against STI

  scope :captured, -> (type = nil) do
    by_captivity_and_type(true, type)
  end

  scope :at_large, -> (type = nil) do
    by_captivity_and_type(false, type)
  end

  private

  def self.by_captivity_and_type(caught, type=nil)
    res = where(:caught => caught)
    if type
      res.where(type: type)
    else
      res.all
    end
  end

end

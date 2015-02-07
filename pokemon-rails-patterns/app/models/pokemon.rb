class Pokemon < ActiveRecord::Base
  self.inheritance_column = nil #Defending against STI

  TYPES = %w(
    bug dark dragon electric fairy fighting fire flying
    ghost grass ground ice normal poison psychic rock
    shadow steel unknown water
    )

  scope :captured, -> { where(caught: true) }
  scope :free, -> { where(caught: false) }
  scope :ordered, -> { order(:type, :id) }

  validates :type, inclusion: { in: TYPES }
  validate :only_two_of_type

  def self.by_type(type)
    if type.nil?
      return all
    else
      where(type: type)
    end
  end

  def catch
    self.caught = true
    save
  end

  def url
    "http://pokemondb.net/pokedex/#{id}"
  end

  def image_url
    "http://img.pokemondb.net/artwork/#{name.downcase}.jpg"
  end

  private

  def only_two_of_type
    if caught == true
      caught_count = Pokemon.captured.by_type(type).count
      if caught_count >= 2
        errors.add(:caught, "has too many of type")
      end
    end
  end
end

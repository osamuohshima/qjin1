class UketsukeRireki < ActiveRecord::Base
  belongs_to :kigyo_daicho
  def self.find_newest(*args)
    with_scope(:find => {:conditions=> uketsuke_nen.maximum }) do
      find(*args)
    end
  end
end

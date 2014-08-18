class KyujinUketsuke < ActiveRecord::Base
  has_one :uketsuke_pdf, :dependent => :destroy
  belongs_to :kigyo_daicho
  belongs_to :kigyo_info, :foreign_key => 'kigyo_bango'
         
  validates_presence_of  :kigyo_bango,:uketsuke_bango,:shokushu_bango,:shokushu_mei,:shokugyo_code,:tenkin,:koutai,:kihonkyu,:kei,:kyujin_sosu
  validates_uniqueness_of :uketsuke_code, :scope => "uketsuke_nen"
  validates_numericality_of :kigyo_bango,:uketsuke_bango,:shokugyo_code,:kyujin_sosu
# attr_trimming_writer :kigyo_bango　

  validate :validates_kigyo_bango_too_less
  validate :validates_kigyo_bango_too_large
  validate :validates_shokushu_bango

  private
  def validates_kigyo_bango_too_less
    errors.add_to_base("企業番号は19850001以上でなければなりません") unless kigyo_bango >= 19850001
  end

  def validates_kigyo_bango_too_large
    errors.add_to_base("企業番号は20510001以下でなければなりません") unless kigyo_bango <= 20510001
  end

  def validates_shokushu_bango
    pos=uketsuke_code.index("-")+1
    errors.add_to_base("職種番号は、受付コードのハイフン以下と同じ番号でなければなりません") unless shokushu_bango==uketsuke_code[pos..-1].to_i
  end
#  def self.define_custom_attr_writer(conversion_name, conversion_proc)
#次のURLを参照　http://www.techscore.com/blog/2012/12/10/%E5%85%A5%E5%8A%9B%E5%80%A4%E3%81%AE%E8%87%AA%E5%8B%95%E5%A4%89%E6%8F%9B/
#    self.singleton_class.send(:define_method, "attr_#{conversion_name}_writer") do |name|
      # name=(value) は Rails によって動的に定義されるので, ここで一度アクセス
#      self.new.send("#{name}=", nil)
# 
#      define_method("#{name}_with_#{conversion_name}=") do |value|
#        value = conversion_proc.call(value) if value.kind_of?(String)
#        send("#{name}_without_#{conversion_name}=", value)
#      end
#      alias_method_chain "#{name}=", conversion_name
#    end
#  end
#  define_custom_attr_writer :trimming, lambda{|value| value.strip}
#  define_custom_attr_writer :downcase, lambda{|value| value.downcase}
#  define_custom_attr_writer :number, lambda{|value| value.tr('０-９', '0-9')}

end

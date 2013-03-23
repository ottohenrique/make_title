require 'digest/sha1'
require './target_formater'

module XYZService
  def self.xyz_filename(target)
    # File format:
    # [day of month zero-padded][three-letter prefix] \
    # _[kind]_[age_if_kind_personal]_[target.id] \
    # _[8 random chars]_[10 first chars of title].jpg
    target_formater = TargetFormater.new target

    filename = "#{target_formater.publish_on}"
    filename << "#{target_formater.xyz_category_prefix}"
    filename << "#{target_formater.kind.gsub("_", "")}"
    filename << target_formater.age
    filename << "_#{target_formater.id}"
    filename << "_#{Digest::SHA1.hexdigest(rand(10000).to_s)[0,8]}"
    filename << "_#{target_formater.title}"
    filename << ".jpg"
    return filename
  end

end

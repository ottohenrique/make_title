module XYZService
  class TargetFormater
    def initialize(target)
      @target = target
    end

    def age
      @target.personal? ? formated_age : '_'
    end

    def title
      cleaned_title[0..title_crop_limit]
    end

    def publish_on
      @target.publish_on.strftime("%d")
    end

    def method_missing meth, *args, &block
      @target.send(meth, args)
    end

    private

    def cleaned_title
      @target.title.gsub(/[^a-z]/i, '').downcase
    end

    def title_crop_limit
      cleaned_title.length > 9 ? 9 : cleaned_title.length
    end

    def formated_age
      "_%03d" % (@target.age || 0)
    end
  end
end

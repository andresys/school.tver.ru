module FormHelper
  def self.included(base)
    ActionView::Helpers::FormBuilder.instance_eval do
      include FormBuilderMethods
    end
  end
  module FormBuilderMethods
    
    # Хелпер для загрузки и отображение фото
    # при new и edit
    def image_field(method, options = {})
      if @object.image_file_name.nil?
        self.multipart = true
        @template.file_field(@object_name, method, objectify_options(options))
      else
        @template.image_tag(@object.image, objectify_options(options))
      end
    end

    def document_field(method, options = {})
      if @object.file_file_name.nil?
        self.multipart = true
        @template.file_field(@object_name, method, objectify_options(options))
      else
        @template.text_field(@object_name, 'title', objectify_options(options))
      end
    end
    
  end
end
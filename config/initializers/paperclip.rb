# encoding: utf-8
require 'uri'
require 'paperclip/url_generator'

module Paperclip
  class Attachment
    def file_name_to_date(file_name)
      extension = File.extname(file_name).downcase
      return "#{Time.now.to_i.to_s}#{extension}"
    end

    def assign uploaded_file
      ensure_required_accessors!
      file = Paperclip.io_adapters.for(uploaded_file)

      self.clear(*only_process)
      return nil if file.nil?

      @queued_for_write[:original] = file
      instance_write(:file_name, cleanup_filename(file_name_to_date(file.original_filename)))
      instance_write(:content_type, file.content_type.to_s.strip)
      instance_write(:file_size, file.size)
      instance_write(:fingerprint, file.fingerprint) if instance_respond_to?(:fingerprint)
      instance_write(:created_at, Time.now) if has_enabled_but_unset_created_at?
      instance_write(:updated_at, Time.now)

      @dirty = true

      post_process(*only_process) if post_processing && valid_assignment?

      # Reset the file size if the original file was reprocessed.
      instance_write(:file_size, @queued_for_write[:original].size)
      instance_write(:fingerprint, @queued_for_write[:original].fingerprint) if instance_respond_to?(:fingerprint)
    end

    def only_process
      only_process = @options[:only_process].dup
      only_process = only_process.call(self) if only_process.respond_to?(:call)
      only_process.map(&:to_sym)
    end

    def valid_assignment? #:nodoc:
      if instance.valid?
        true
      else
        instance.errors.none? do |attr, message|
          attr.to_s.start_with?(@name.to_s)
        end
      end
    end
  
  end
end
module Paperclip
  class Audio < Processor
    
    class InstanceNotGiven < ArgumentError; end
      
    def initialize(file, options = {}, attachment = nil)
      super
      @attachment = attachment
      @file = file
      @instance = options[:instance]
      @current_format   = File.extname(@file.path)
      @basename         = File.basename(@file.path, @current_format)
      @original_extname = File.extname(@attachment.original_filename)
      @original_basename = File.basename(@attachment.original_filename,@original_extname)
    end
    
    def make
      @file.pos = 0 # Reset the file position incase it is coming out of a another processor
      if @original_extname.eql? ".wav"
        dst = Tempfile.new([@original_basename, "ogg"].compact.join("."))
        @attachment.instance_write :file_name, [@original_basename, "ogg"].compact.join(".")
        begin
          success = Paperclip.run "oggenc", "-o #{dst.path} #{@file.path}"
        rescue PaperclipCommandLineError
          raise PaperclipError, "There was an error processing the file #{@basename}" if @whiny
        end
        return dst
      end
      @file
    end
    
  end
end

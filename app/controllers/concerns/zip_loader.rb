module ZipLoader
  extend ActiveSupport::Concern

  included do

    def create
      if params[:archive].present?
        BulkService.call params[:archive]
        flash[:success] = "Данные успешно загружены"
      end

      redirect_back
    end
    
    private

    def respond_with_zipped(obj)
      compressed_filestream = Zip::OutputStream.write_buffer do |zos|
        obj.model_name.human.constantize.order(created_at: :desc).each do |obj|

          zos.put_next_entry "#{obj.model_name.to_s}_#{obj.id}.xlsx"
          zos.print render_to_string(
                      layout: false, handlers: [:axlsx], formats: [:xlsx],
                      template: "admin/#{obj.model_name.collection}/#{obj.model_name.element}",
                      locals: {"#{obj.model_name.element}": obj})
        end
        
      end

      compressed_filestream.rewind
      send_data compressed_filestream.read, filename: "#{obj.model.to_s}s.zip"
    end
  end
end

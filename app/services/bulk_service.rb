class BulkService < ApplicationService
  attr_reader :archive

  def initialize(archive_parm)
    @archive = archive_parm.tempfile
  end

  def call
    Zip::File.open(@archive) do |zip_file|
      zip_file.each do |entry|
        User.import data_from(entry), ignore: true
      end
    end
  end


  private
  def data_from(entry)
    sheet = RubyXL::Parser.parse_buffer(entry.get_input_stream.read)[0]
    if request.original_url.match? /users/
      users_from(sheet)
    else
      articles_from(sheet)
    end
  end

  def users_from(sheet)
    sheet.each do |row|
      cells = row.cells
      User.new name: cells[0].value,
               email: cells[1].value,
               password: cells[2].value,
               password_confirmation: cells[2].value
    end
  end

  def articles_from(sheet)
    sheet.each do |row|
      cells = row.cells
      Article.new title: cells[0].value,
               body: cells[1].value
    end
  end
  
end

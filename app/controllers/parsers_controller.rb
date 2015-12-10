class ParsersController < ApplicationController
  require 'rexml/document'
  require 'gedcom_parser'
  include GedcomParser

  def upload_file
    path = params[:upload][:datafile].tempfile.path

    # Method defined inside GedcomParser Module
    xml = generate_xml(path)
    send_data xml, :type => 'text/xml; charset=UTF-8;', :disposition => "attachment; filename=result.xml"
  end

end

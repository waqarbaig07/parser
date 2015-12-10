module GedcomParser
  require 'rexml/document'

  def generate_xml(path)
    doc = REXML::Document.new "<gedcom/>"
    nodes = [doc.root]
    File.open(path, "r") do |f|
      f.each_line do |line|
        next if line =~ /^\s*$/
        @l = parse(line)

        while (level+1) < nodes.size
          nodes.pop
        end
        @parent = nodes.last

        @elem = nil
        update_elem

        nodes.push @elem
      end
    end
    nodes[0]
  end

  private
  def parse(line)
    line.match(/^\s*(?<level>\d+)\s+(?<tag>@\S+@|\S+)(\s(?<data>.*))?$/)
  end

  def level
    @l['level'].to_i
  end

  def tag
    @l['tag']
  end

  def data
    @l['data']
  end

  def update_elem
    if tag =~ /@.+@/
      @elem = @parent.add_element data
      @elem.attributes['id'] = tag
    else
      @elem = @parent.add_element tag
      @elem.text = data
    end
  end

end

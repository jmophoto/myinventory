class InspectionPdf < Prawn::Document
  
  def initialize(inspection, view)
    super(margin: 20)
    @inspection = inspection
    @view = view
    header_box

    address
    info_box
    valuables
    rooms
    
    # property_images
    # room_images
  end
  
  def header_box
    fill_color '5F7FB0'
    fill_rectangle [-bounds.absolute_left, cursor + 20], bounds.absolute_left + bounds.absolute_right, 100
    fill_color '000000'
    image("#{Rails.root}/app/assets/images/mi_logo_white.png", height: 80, position: 400, vposition: -10)
    move_down 10
  end
  
  def address
    bounding_box([0, cursor - 10], width: 200) do
      font_size(18) do
        text_box @inspection.address.try(:full_address) || ''
      end
    end
  end

  def info_box
    bounding_box([300, cursor], width: 200) do
      font_size(12)
      table([["Inventory Date:","#{@inspection.inspection_date}" ]], width: 250, column_widths: [125, 125], :cell_style => { :borders => [:bottom], :padding => 10 })
      table([["Report Date:","#{@inspection.report_date}" ]], width: 250, column_widths: [125, 125], :cell_style => { :borders => [:bottom], :padding => 10 })
      table([["Inventory Type:","#{@inspection.inspection_type }" ]], width: 250, column_widths: [125, 125], :cell_style => { :borders => [:bottom], :padding => 10 })
    end
  end

  def details
    text "Property Details", size: 25, align: :center
    stroke do
      stroke_color "EEEEEE"
      horizontal_rule
    end
    move_down 20
    details = [["Feature", "Status", "Comments"]]
    details += @inspection.inspection_details.map{|x| [x.name, humanize(x.status), x.comment]}
    font_size(10) do
      table(details, :width => bounds.right, :row_colors => ["EEEEEE", "FFFFFF"], :header => true) do
        cells.borders = [:bottom]
        cells.padding = [10, 5, 10, 5]
        row(0).font_style = :bold
        row(0).columns(2).align = :center
        columns(2).width = 300
      end
    end
    move_down 40
  end

  def valuables
    move_down 30
    text 'Valuables', size: 25, align: :center
    @inspection.valuables.each_with_index do |v, index|
      move_down 20
      features = [["Serial Number", "Comments"]]
      features += [[v.serial_number, v.comments]]
      font_size(10) do
        table(features, :width => bounds.right, :row_colors => ["EEEEEE", "FFFFFF"], :header => true) do
          cells.borders = [:bottom]
          cells.padding = [10, 5, 10, 5]
          row(0).font_style = :bold
          row(0).columns(4).align = :center
          columns(4).width = 200
        end
      end
      if v.images.any?
        move_down 20
        image_urls = v.images.map(&:small_url)
        y_index = cursor
        width = bounds.right/3
        height = bounds.right/5
        v.images.in_groups_of(3).map do |image_row|
          image_row.each_with_index do |image_file, index|
            bounding_box([bounds.left + (width*index), y_index], width: width, height: height) do
              if image_file && image_file.asset
                image "#{Rails.root}/public#{image_file.asset.url(:small)}", fit: [width-20, height-20], position: :center
                text_box "#{image_file.comment}", at: [bounds.left+10, cursor-10], width: width, size: 8
              end
            end
          end
          y_index -= height + 50
        end
      end
    end
    start_new_page
  end
  
  def rooms
    move_down 30
    rooms = @inspection.inspected_rooms
    rooms.each_with_index do |room, index|
      text room.name, size: 25, align: :center
      move_down 20
      features = [["Feature", "Comments"]]
      features += room.inspected_features.map{|x| [x.name, x.comment]}
      font_size(10) do
        table(features, :width => bounds.right, :row_colors => ["EEEEEE", "FFFFFF"], :header => true) do
          cells.borders = [:bottom]
          cells.padding = [10, 5, 10, 5]
          row(0).font_style = :bold
          row(0).columns(4).align = :center
          # columns(1..3).align = :center
          columns(4).width = 200
        end
      end
      if room.images.any?
        move_down 20
        image_urls = room.images.map(&:small_url)
        y_index = cursor
        width = bounds.right/3
        height = bounds.right/3
        room.images.in_groups_of(3).map do |image_row|
          image_row.each_with_index do |image_file, index|
            bounding_box([bounds.left + (width*index), y_index], width: width, height: height) do
              if image_file && image_file.asset
                image "#{Rails.root}/public#{image_file.asset.url(:small)}", fit: [width-20, height-20], position: :center
                text_box "#{image_file.comment}", at: [bounds.left+10, cursor-10], width: width, size: 8
              end
            end
          end
          y_index -= height + 50
        end
      end
      start_new_page if (index+2) <= rooms.length
    end
  end

  def property_images
    text "Property Images", size: 25, align: :center
    stroke do
      stroke_color "EEEEEE"
      horizontal_rule
    end
    move_down 20
    y_index = cursor
    width = bounds.right/3
    height = bounds.right/3
    @inspection.images.in_groups_of(3).map do |image_row|
      image_row.each_with_index do |image_file, index|
        bounding_box([bounds.left + (width*index), y_index], width: width, height: height) do
          if image_file && image_file.asset
            image "#{Rails.root}/public#{image_file.asset.url(:small)}", fit: [width-20, height-20], position: :center
            text_box "#{image_file.comment}", at: [cursor, cursor-10], width: width-20, height: 50, overflow: :shrink_to_fit
          end
        end
      end
      y_index -= height + 50
    end
  end
  
  def room_images
    @inspection.inspected_rooms.each do |room|
      if room.images.any?
        start_new_page
        text "#{room.name} Images", size: 25, align: :center
        stroke do
          stroke_color "EEEEEE"
          horizontal_rule
        end
        move_down 20
        image_urls = room.images.map(&:small_url)
        y_index = cursor
        width = bounds.right/3
        height = bounds.right/3
        room.images.in_groups_of(3).map do |image_row|
          image_row.each_with_index do |image_file, index|
            bounding_box([bounds.left + (width*index), y_index], width: width, height: height) do
              if image_file && image_file.asset
                image "#{Rails.root}/public#{image_file.asset.url(:small)}", fit: [width-20, height-20], position: :center
                text_box "#{image_file.comment}", at: [cursor, cursor-10], width: width-20, height: 50, overflow: :shrink_to_fit
              end
            end
          end
          y_index -= height + 50
        end
      end
    end
  end
  
  def humanize(string)
      string.to_s.humanize
  end
  
  def true_to_clean(string)
    if string == true
      "Clean"
    elsif string == false
      "Dirty"
    else
      ""
    end
  end
  
  def marks_and_damage(marks, damage)
    if marks == true && damage == true
      "Marks & Damage"
    elsif marks == true
      "Marks"
    elsif damage == true
      "Damage"
    else
      ""
    end
  end
  
  
end
